class RenameColumnTypeToMove < ActiveRecord::Migration[6.1]
  def change
    rename_column :moves, :type, :house_type
  end
end
