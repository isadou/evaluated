class ChangeVolumeToStuffs < ActiveRecord::Migration[6.1]
  def change
    change_column :stuffs, :volume, :decimal, precision: 3, scale: 1
  end
end
