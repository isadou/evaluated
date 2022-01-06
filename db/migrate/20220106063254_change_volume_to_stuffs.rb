class ChangeVolumeToStuffs < ActiveRecord::Migration[6.1]
  def change
    change_column :stuffs, :volume, :decimal, precision: 4, scale: 2, default: 0
  end
end
