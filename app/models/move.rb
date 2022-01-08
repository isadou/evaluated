class Move < ApplicationRecord
  belongs_to :user
  has_many :rooms, dependent: :destroy

  geocoded_by :depart, latitude: :depart_latitude, longitude: :depart_longitude
  after_validation :geocode, if: :will_save_change_to_depart?

  # geocoded_by :arrivee, latitude: :arrivee_latitude, longitude: :arrivee_longitude
  # after_validation :geocode, if: :will_save_change_to_arrivee?

  #COLLECTIONS
  LOGEMENTS = ["Appartement", "Studio", "Maison"]
end
