class CreateInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories do |t|
      t.references :room, null: false, foreign_key: true
      t.references :stuff, null: false, foreign_key: true

      t.timestamps
    end
  end
end
