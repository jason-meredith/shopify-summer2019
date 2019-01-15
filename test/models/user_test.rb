require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "adding to cart" do

    user = users(:jason)
    product = products(:car)
    stock = product.inventory_count

    # Test successful adding
    assert_empty(user.cart_products)
    assert(user.enough_temp_inventory(product, stock - 1))

    assert_no_difference("product.inventory_count",
                         'Adding to cart should\'t affect the inventory count') do
      user.add_product_to_cart(product, stock - 1)
    end

    assert_not_empty(user.cart_products)


    # Add some, then add too many
    assert(user.enough_temp_inventory(product, 1))
    user.add_product_to_cart(product, 1)
    assert_equal(2, user.cart_products.count)
    assert_not(user.enough_temp_inventory(product, 1))


    # Start by adding too many
    user.cart_products.clear
    assert_empty(user.cart_products)
    assert_not(user.enough_temp_inventory(product, stock + 1))
    user.add_product_to_cart(product, stock + 1)
    assert_empty(user.cart_products, 'Cart should be empty because there is not enough product in stock')


  end

  test "cart total" do
    user = users(:jason)
    product = products(:beverage)
    amount = 3

    user.add_product_to_cart(product, amount)
    assert_equal(product.price * amount, user.cart_total)
  end

  test "purchasing" do
    user = users(:jason)
    product = products(:beverage)
    amount = 2

    start_inventory = product.inventory_count

    user.add_product_to_cart(product, amount)

    assert_equal(1, user.cart_products.count)

    cost = user.checkout

    assert_equal(product.price * amount, cost)
    assert_equal(start_inventory - amount, product.inventory_count)


  end

end
