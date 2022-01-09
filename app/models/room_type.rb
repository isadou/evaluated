class RoomType < ApplicationRecord
  has_many :rooms
  has_many :stuffs

  ROOM_TYPES = RoomType.all.order(:name).map { |type| type.name }.uniq
end
