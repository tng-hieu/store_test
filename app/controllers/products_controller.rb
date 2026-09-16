class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :set_categories, only: %i[ new create edit show index ]

  # GET /products or /products.json
  def index
    @pagy, @products = pagy(Product.includes(:category).where(is_deleted: false), limit: 10, max_limit: 100)
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
    if @product.save
      redirect_to products_path, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    @product.update(is_deleted: true)
      redirect_to products_url, notice: "Product was successfully destroyed."
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: "Product was successfully updated.", status: :see_other
    else
      render :show, status: :unprocessable_entity
    end
  end

  def product_params
    params.expect(product: [:name, :code, :sequence, :is_active, :category_id])
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_categories
    @categories = Category.where(is_delete: false).order(:sequence)
  end
end
