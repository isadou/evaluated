class Room < ApplicationRecord
  belongs_to :move
  belongs_to :room_type
  has_many :inventories, dependent: :destroy
  has_many :stuffs, through: :inventories
end
