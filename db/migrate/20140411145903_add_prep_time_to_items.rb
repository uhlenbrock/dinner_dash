class AddPrepTimeToItems < ActiveRecord::Migration
  def change
    add_column :items, :prep_time, :integer
  end
end
