class AddCounterCaches < ActiveRecord::Migration
  
  def change
    add_column :categories, :items_count, :integer, default: 0
    add_column :sales, :items_count, :integer, default: 0
  end
  
end
