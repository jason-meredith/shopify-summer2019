class CreateCartProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_products do |t|

      t.integer :amount

      # Create the many-to-many association
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true

      t.timestamps
    end
  end
end
