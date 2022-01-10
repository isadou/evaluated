class AddDistanceToMoves < ActiveRecord::Migration[6.1]
  def change
    add_column :moves, :distance, :integer
  end
end
