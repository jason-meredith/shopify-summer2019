class User < ApplicationRecord

  has_many :cart_products
  has_many :products, through: :cart_products

  # Add a given amount of a given product to a User's shopping cart
  def add_product_to_cart(product, amount)

    amount = amount.to_i

    if enough_temp_inventory(product, amount)
      cart_product = CartProduct.new(product: product, amount: amount)
      cart_products << cart_product

      {
          cart_product_id: cart_product.id,
          cart_total: cart_total,
          success: true,
          message: "Added #{amount} #{product.title} to cart"
      }

    else
      {
          success: false,
          message: "Not enough #{product.title} in stock to add to cart"
      }
    end

  end

  # Returns whether or not there is enough of a product in stock to add given amount to cart
  def enough_temp_inventory(product, amount)
    total = amount

    cart_products.each do |p|
      if p.product == product
        total += p.amount
      end
    end

    total <= product.inventory_count
  end

  # Returns the total cost of all items in a User's shopping cart
  def cart_total
    total = 0

    cart_products.each do |p|
      total += p.product.price * p.amount
    end

    total
  end

  # Purchase all shopping cart items, decreasing their total inventory_count and emptying the cart
  def checkout

    cost = cart_total

    cart_products.each do |p|
      p.product.inventory_count -= p.amount
    end

    cart_products.clear

    cost

  end

end
