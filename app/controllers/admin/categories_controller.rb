class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
    if @category.save

        format.html { flash[:notice] = "created new category!"}
        format.js
    else
        format.html { flash[:success] = "created new category!"}
        format.js { render layout: false }
    end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { respond_with_bip(@category) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@category) }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { flash[:success] = "deleted category!" }
      format.js { render layout: false }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description)
    end
end
