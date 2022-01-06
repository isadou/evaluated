class ChangeNumericTypesToStuff < ActiveRecord::Migration[6.1]
  def change
    change_column :stuffs, :volume, :float, default: 0
    change_column :stuffs, :volume_carton, :float, default: 0
  end
end
