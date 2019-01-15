class Api::UsersController < ApplicationController



  # Adds a product to a user cart
  def add_to_cart
    product = Product.find(params[:product_id])
    amount = params[:amount]

    render json: User.find(params[:id]).add_product_to_cart(product, amount)

  end

  # Show a list of all users
  def list
    render json: User.all
  end

  # Remove a cart item from a users cart
  def remove_from_cart
    render json: CartProduct.find(params[:id]).destroy
  end

  # Create a new user
  def create
    user_details = params.permit(:first_name, :last_name, :email)
    success = User.create(user_details)

    render json: { success: success }
  end

  # Show the items in a user's cart
  def show_cart
    render json: User.find(params[:id]).cart_products
  end

  # Show the total cost of all the products in a users cart
  def show_cart_total
    render plain: User.find(params[:id]).cart_total
  end

  # Show details of a single user
  def show
    user = User.find(params[:id])

    render json: user
  end

  # Purchase all items in a user's cart
  def checkout
    user = User.find(params[:id])

    render json: {
        cost: user.checkout,
        transaction: 'success'
    }


  end

end
