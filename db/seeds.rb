# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'csv'
require 'pry-byebug'

Inventory.destroy_all
Stuff.destroy_all
Room.destroy_all
RoomType.destroy_all
Move.destroy_all
User.destroy_all

user = User.create!(email: "lilia@evaluated.com", first_name: "Lilia", last_name: "Bekrar", telephone: "0678901234", password: "123456")
p "#{user.email} created"

# pour les moves le champ transport sera déterminé en fonction du volume... l user ne peut pas le saisir
move = Move.new(depart: "25 chemin des brumes, Fos sur Mer", arrivee: "Paris", house_type: "appartement", acces: 'true', transport: "", user_id: user.id)
move.save!
p "#{move.user.first_name}'s move created"

# pour le csv j'ai fais ca mais c'est faux faudra le voir ensemble je pense

csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filepath    = Rails.root.join("db/volumetrie.csv")

# room = Room.new(name: "chambre", move: "move_id", room_type: "room_type_id")
# p "#{room.name} created"

# test CSV.new(open(filepath, csv_options)).each do |row|
CSV.foreach(filepath, csv_options) do |row|
  # #{row['ROOM_TYPE']}, #{row['STUFFS']}, #{row['VOLUME']}, #{row['CARTON']}, #{row['VOLUME_CARTON']}, #{row['HOUSSE 90']}, #{row['HOUSSE 140']}, #{row['COUVERTURE']}

  RoomType.create!(name: row['ROOM_TYPE'].rstrip) if RoomType.find_by(name: row['ROOM_TYPE'].rstrip).nil?

  stuff = Stuff.create!(name: row['STUFFS'], volume: row['VOLUME'], carton: row['CARTON'], room_type_id: RoomType.find_by(name: row['ROOM_TYPE'].rstrip).id, volume_carton: row['VOLUME_CARTON'])
  p "#{stuff.name} created"
end

user = User.create!(email: "Isadou@evaluated.com", first_name: "Isabelle", last_name: "Douin", telephone: "0678901234", password: "123456")
p "#{user.email} created"

user = User.create!(email: "maewenn@evaluated.com", first_name: "Maewenn", last_name: "Drean", telephone: "0612345678", password: "123456")
p "#{user.email} created"

user = User.create!(email: "georgia@evaluated.com", first_name: "Georgia", last_name: "Drai",telephone: "0712345678", password: "123456")
p "#{user.email} created"
