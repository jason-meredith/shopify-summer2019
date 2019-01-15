class Api::ProductsController < ApplicationController

  # Get an array of all products, unless in_stock_only=true in which we only
  # return in stock products
  def index
    products = Product.all

    if params.fetch('in_stock', 'false') == 'true'
      products = products.where('inventory_count > 0')
    end

    render json: products
  end

  # Create a new product based on POST data
  def create

    product_details = params.permit(:title, :inventory_count, :price)
    success = Product.create(product_details)

    render json: { success: success }
  end

  # Show details of a single product
  def show
    product = Product.find_by_id(params[:id])

    render json: product
  end

  # Change the properties of a single product identified by id
  def update
    product = Product.find(params[:id])
    product_details = params.permit(:title, :inventory_count, :price)

    product.update(product_details)

    render json: product
  end

  # Delete a product, return the id of the deleted product
  def destroy
    product = Product.find(params[:id])
    product.destroy

    render json: { deleted: params[:id] }
  end



end
