class CreateHightowerSegments < ActiveRecord::Migration
  def change
    create_table :hightower_segments do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :hightower_segments, :name
  end
end
