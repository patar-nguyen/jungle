class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: 'Jungle', password: 'book'
  #displays the number of products and categories
  def show
    @product = Product.count
    @category = Category.count
  end

end
