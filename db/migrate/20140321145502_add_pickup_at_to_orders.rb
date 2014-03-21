class AddPickupAtToOrders < ActiveRecord::Migration
  
  def change
    change_table :orders do |t|
      t.datetime :pickup_at
    end
  end
  
end
