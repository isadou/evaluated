class ChangeVolumeCartonToStuffs < ActiveRecord::Migration[6.1]
  def change
    change_column :stuffs, :volume_carton, :decimal, precision: 4, scale: 2, default: 0
  end
end
