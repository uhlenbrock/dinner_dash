class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :discount
      t.string :title
      t.boolean :active, default: true
      t.timestamps
    end
    add_column :items, :sale_id, :integer
  end
end
