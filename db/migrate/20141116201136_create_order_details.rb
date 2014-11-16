class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.references :order, index: true
      t.string :item_name
      t.integer :unit_price
      t.integer :quantity

      t.timestamps
    end
  end
end
