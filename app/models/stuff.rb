class Stuff < ApplicationRecord
  belongs_to :room_type
  has_many :inventories
end
