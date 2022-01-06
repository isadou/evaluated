class RoomType < ApplicationRecord
  has_many :rooms
  has_many :stuffs

  ROOM_TYPES = RoomType.all.map { |type| type.name.capitalize }.uniq
end
