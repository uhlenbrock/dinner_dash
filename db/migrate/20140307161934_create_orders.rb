class CreateOrders < ActiveRecord::Migration
  
  def change
    create_table :orders do |t|
      t.string :order_status
      t.references :user
      t.timestamps
    end
    create_table :items_orders, id: false do |t|
      t.references :item
      t.references :order
    end
  end
  
end
