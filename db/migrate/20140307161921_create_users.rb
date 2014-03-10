class CreateUsers < ActiveRecord::Migration
  
  def change
    create_table :users do |t|
      t.string :name, :email
      t.string :password_digest
      t.boolean :admin, default: false, null: false
      t.timestamps
    end
  end
  
end
