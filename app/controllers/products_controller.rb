class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @pagy, @products = pagy(Product.where(is_deleted: false), limit: params[:per_page] || 10)
  end

  def show
  end
  # use same template for edit and show
  def edit
    render :show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product[:code].present? && Product.exists?(code: @product[:code], is_deleted: false)
      flash.now[:alert] = "Sản phẩm '#{@product[:code]}' đã tồn tại trong hệ thống!"
      return render :new, status: :unprocessable_entity
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @product.update(is_deleted: true)
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: "Product was successfully updated.", status: :see_other }
      else
        render :show, status: :unprocessable_entity
      end
    end
  end

  def product_params
    params.expect(product: [:name, :code, :sequence, :is_active])
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
