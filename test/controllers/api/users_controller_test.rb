require 'test_helper'
require 'json'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest

  test "adding to cart" do

    user = users(:jason)
    beverage = products(:beverage)
    amount = 4


    assert_equal(0, user.cart_products.count)

    post api_add_to_cart_path(user.id),
         params: { product_id: beverage.id, amount: amount }

    result = JSON.parse(@response.body)

    if beverage.inventory_count >= amount
      assert result['success']
    else
      assert_not result['success']
    end

    assert_equal(1, user.cart_products.count)

  end

  test "remove from cart" do
    user = users(:jason)

    cart_product = nil
    assert_difference("user.cart_products.count") do
      cart_product = CartProduct.create(user: user, product: products(:beverage), amount: 1)
      user.cart_products << cart_product
    end

    delete api_remove_from_cart_path(cart_product.id)

    assert_equal(0, user.cart_products.count)
  end


  test "create user" do

    new_user_details = { first_name: 'Lloyd', last_name: 'Braun', email: 'l_braun@kramerica.org' }

    assert_difference("User.count") do
      post api_create_user_path,
           params: new_user_details
    end

    newest_user = User.last

    assert_equal(new_user_details[:first_name], newest_user.first_name)
    assert_equal(new_user_details[:last_name], newest_user.last_name)
    assert_equal(new_user_details[:email], newest_user.email)

  end

  test "show cart" do
    user = users(:jason)

    get api_show_cart_path(user.id)

    assert_equal('[]', @response.body)

    cart_product = CartProduct.create(user: user, product: products(:beverage), amount: 1)
    user.cart_products << cart_product

    get api_show_cart_path(user.id)

    assert_equal([ cart_product ].to_json, @response.body)

  end

  test "show cart total" do
    user = users(:jason)

    get api_show_cart_total_path(user.id)

    assert_equal('0', @response.body)

    cart_product = CartProduct.create(user: user, product: products(:beverage), amount: 3)
    user.cart_products << cart_product

    get api_show_cart_total_path(user.id)

    assert_equal((products(:beverage).price * cart_product.amount).to_s, @response.body)

  end

  test "show user details" do
    user = users(:jason)

    get api_user_details_path(user.id)

    result = JSON.parse(@response.body)

    assert_equal(user.first_name, result['first_name'])
    assert_equal(user.last_name, result['last_name'])
    assert_equal(user.email, result['email'])

  end

  test "show all users" do
    get api_user_list_path

    result = @response.body

    assert_equal(User.all.to_json, result)

  end

  test "purchasing" do
    user = users(:jason)
    product = products(:beverage)
    amount = 2

    start_inventory = product.inventory_count

    user.add_product_to_cart(product, amount)

    assert_equal(1, user.cart_products.count)

    post api_checkout_path(user.id)

    cost = JSON.parse(@response.body)['cost']

    assert_equal((product.price * amount).to_s, cost)

  end

end

