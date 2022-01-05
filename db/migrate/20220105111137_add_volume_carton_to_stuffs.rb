class AddVolumeCartonToStuffs < ActiveRecord::Migration[6.1]
  def change
    add_column :stuffs, :volume_carton, :decimal, precision: 3, scale: 1
  end
end
