class StorefrontController < ApplicationController
  def index

    if params[:search]
      @products = Product.search_by_name_or_description(params[:search])
      if @products.empty?
        flash.now[:notice] = "Nothing found for \"#{params[:search]}\"."
        @products = Product.all
      end
    elsif params[:cat_id]
      # only get things from specific category
      @category = Category.find(params[:cat_id])
      @products = Product.where(category_id: params[:cat_id])
    else
      @products = Product.all
    end
  end

  def about
  end
end
