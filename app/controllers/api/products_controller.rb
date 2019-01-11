class Api::ProductsController < ApplicationController

  def index
    products = Product.all

    render json: products
  end

  def create

    product_details = params.permit(:title, :inventory_count, :price)
    success = Product.create(product_details)

    render json: { success: success }
  end

  def show
    product = Product.find_by_id(params[:id])

    render json: product
  end

  def update
    product = Product.find(params[:id])
    product_details = params.permit(:title, :inventory_count, :price)

    product.update(product_details)

    render json: product
  end

  def destroy
    product = Product.find(params[:id])

    product.destroy

    render json: { deleted: params[:id] }
  end



end
