class User < ApplicationRecord

  has_many :cart_products
  has_many :products, through: :cart_products

  def add_product_to_cart(product, amount)

    amount = amount.to_i

    if enough_temp_inventory(product)
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

  def enough_temp_inventory(product)
    total = 0

    cart_products.each do |p|
      if p.product == product
        total += p.amount
      end
    end

    total <= product.inventory_count
  end


  def cart_total
    total = 0

    cart_products.each do |p|
      total += p.product.price * p.amount
    end

    total
  end

end
