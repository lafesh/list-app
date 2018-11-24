class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.string :item 
      t.timestamps
      t.integer :list_id
    end
  end
end
