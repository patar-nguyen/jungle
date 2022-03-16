class Admin::CategoriesController < ApplicationController
  #admin access only with username and password
  http_basic_authenticate_with name: 'Jungle', password: 'book'
  #list of all categories
  def index
    @categories = Category.all
  end
  #creates new category
  def new
    @category = Category.new
  end

  # admin can create a new category
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end