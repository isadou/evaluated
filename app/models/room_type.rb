class RoomType < ApplicationRecord
  has_many :rooms
  has_many :stuffs
end
