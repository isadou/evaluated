class CreateStuffs < ActiveRecord::Migration[6.1]
  def change
    create_table :stuffs do |t|
      t.string :name
      t.integer :volume
      t.integer :carton
      t.integer :carton_livre
      t.references :room_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
