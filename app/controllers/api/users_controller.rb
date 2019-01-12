class Api::UsersController < ApplicationController



  def add_to_cart
    product = Product.find(params[:product_id])
    amount = params[:amount]

    render json: User.find(params[:user_id]).add_product_to_cart(product, amount)

  end

  def remove_from_cart
    render json: CartProduct.find(params[:cart_product_id]).destroy
  end

  def create
    user_details = params.permit(:first_name, :last_name, :email)
    success = User.create(user_details)

    render json: { success: success }
  end

  def show_cart

    headers['Last-Modified'] = Time.now.httpdate
    render json: User.find(params[:user_id]).cart_products
  end

  def show_cart_total
    render json: User.find(params[:user_id]).cart_total
  end

  def adjust_cart_item_amount
    adjustment = params.permit(:amount, :cart_product_id)
    cart_product = CartProduct.find(params[:cart_product_id])
    cart_product.update(adjustment)
    render json: cart_product

  end

  def show
    user = User.find_by_id(params[:id])

    render json: user
  end

end
