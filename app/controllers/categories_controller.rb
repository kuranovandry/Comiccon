class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @books = @category.books.paginate(page: params[:page], per_page: params[:per_page])
  end
end
