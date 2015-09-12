class CreateHightowerEvents < ActiveRecord::Migration
  def change
    create_table :hightower_events do |t|
      t.integer :user_id
      t.string :action
      t.text :meta

      t.timestamps null: false
    end
    add_index :hightower_events, :user_id
    add_index :hightower_events, :action
  end
end
