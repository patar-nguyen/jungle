class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: 'Jungle', password: 'book'

  def show
    @product = Product.count
    @category = Category.count
  end

end
