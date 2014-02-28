class CreateCategories < ActiveRecord::Migration
  
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
    change_table :items do |t|
      t.references :category
    end
  end
end
