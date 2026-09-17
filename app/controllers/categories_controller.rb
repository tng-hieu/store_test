class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @page = (params[:page] || 1).to_i
    @per_page = (params[:per_page] || 10).to_i

    query = Category.where(is_delete: false).order(:sequence)
    @total_count = query.count
    @categories = query.limit(@per_page).offset((@page - 1) * @per_page)
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    render :show
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    newItemCode = @category[:code]
    if newItemCode.present? && Category.exists?(code: newItemCode, is_delete: false)
      flash.now[:alert] = "Danh mục '#{newItemCode}' đã tồn tại trong hệ thống!"
      return render :new, status: :unprocessable_content
    end
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @category.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: "Category was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :show, status: :unprocessable_content }
        format.json { render json: @category.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to categories_path, notice: "Category was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.expect(category: [ :name, :code, :sequence, :is_active ])
    end
end
