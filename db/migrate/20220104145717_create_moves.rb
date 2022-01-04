class CreateMoves < ActiveRecord::Migration[6.1]
  def change
    create_table :moves do |t|
      t.text :depart
      t.text :arrivee
      t.string :type
      t.boolean :acces, default: true
      t.string :transport
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
