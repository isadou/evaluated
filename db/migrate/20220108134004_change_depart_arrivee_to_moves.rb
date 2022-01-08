class ChangeDepartArriveeToMoves < ActiveRecord::Migration[6.1]
  def change
    change_column :moves, :depart, :string
    change_column :moves, :arrivee, :string
  end
end
