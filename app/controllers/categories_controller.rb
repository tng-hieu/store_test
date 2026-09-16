class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @page = (params[:page] || 1).to_i
    @per_page = (params[:limit] || 10).to_i

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
    if @category.save
      redirect_to categories_path, notice: "Category was successfully created." 
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category was successfully updated.", status: :see_other
    else
      render :show, status: :unprocessable_content
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!
    redirect_to categories_path, notice: "Category was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.expect(category: [ :name, :code, :sequence, :is_active, :is_delete ])
    end
end
