class AddCoordinatesToMoves < ActiveRecord::Migration[6.1]
  def change
    add_column :moves, :depart_latitude, :float
    add_column :moves, :depart_longitude, :float
    add_column :moves, :arrivee_latitude, :float
    add_column :moves, :arrivee_longitude, :float
  end
end
