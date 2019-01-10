class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|

      # Name of the product
      t.string :title

      # Price of product
      t.decimal :price, precision: 5, scale: 2

      # Amount in stock
      t.integer :inventory_count

      t.timestamps
    end
  end
end
