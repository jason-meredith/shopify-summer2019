class Product < ApplicationRecord
  has_many :cart_products
  has_many :users, through: :cart_products
end
