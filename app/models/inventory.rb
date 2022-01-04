class Inventory < ApplicationRecord
  belongs_to :room
  belongs_to :stuff
end
