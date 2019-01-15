require 'test_helper'

class Api::ProductsControllerTest < ActionDispatch::IntegrationTest

  test "get all products" do
    get api_products_path
    products = JSON.parse(@response.body)

    # Make sure the results include five products
    assert_equal(5, products.count, "Get all products should return an array with 5 elements")

    # Try again with 'in_stock_only' parameter to true
    get api_products_path,
        params: { in_stock_only: 'true' }
    products = JSON.parse(@response.body)

    # Make sure the results include four products
    assert_equal(4, products.count, "Total of in stock items should be four")


  end

  test "create new product" do
    assert_difference('Product.count') do
      post api_products_path,
         params: { title: 'New Product', inventory_count: 8, price: 9.99 }
    end

    new_product = Product.last

    # Make sure values of the newest product match the product we just created
    assert_equal('New Product', new_product.title)
    assert_equal(8, new_product.inventory_count)
    assert_equal(9.99, new_product.price)
  end

  test "show single product details" do
    test_product = Product.first

    get api_product_path(test_product.id)

    result_product = JSON.parse(@response.body)

    assert_equal(test_product.title, result_product['title'])
    assert_equal(test_product.inventory_count, result_product['inventory_count'])
    assert_equal(test_product.price, result_product['price'].to_f)

  end

  test "update a product" do
    test_product = Product.first
    test_price = test_product.price
    test_inventory_count = test_product.inventory_count

    put api_product_path(test_product.id),
        params: { inventory_count: test_inventory_count+10, price: test_price+10 }

    new_test_product = Product.find(test_product.id)
    assert_not_equal(test_price, new_test_product.price)
    assert_not_equal(test_inventory_count, new_test_product.inventory_count)

  end

  test "destroy a product" do
    last_product = Product.last

    delete api_product_path(last_product.id)

    new_last_product = Product.last

    assert_not_equal(last_product.id, new_last_product.id)

  end



end
