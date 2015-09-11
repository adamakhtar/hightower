class CreateHightowerPersonas < ActiveRecord::Migration
  def change
    create_table :hightower_personas do |t|
      t.integer :user_id
      t.integer :segment_id
      t.boolean :processed, default: false, null: false

      t.timestamps null: false
    end
    add_index :hightower_personas, :user_id
    add_index :hightower_personas, :segment_id
    add_index :hightower_personas, :processed
  end
end
