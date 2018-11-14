class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :list_title
      t.string :list_item
      t.boolean :finished
      t.integer :user_id
      t.timestamps
    end
  end
end
