class MovesController < ApplicationController
  before_action :set_move, only: [:destroy, :update, :edit, :rooms_list, :add_stuffs, :recap, :details, :create_rooms]
  before_action :set_user, only: [:new, :create]
  before_action :set_room, only: [:add_stuffs, :create_stuffs]

  # method crud
  def index
    @moves = Move.where(user_id: current_user.id)
    @volumes = {}
    @moves.each do |move|
      @volumes[move] = strip_trailing_zero(volume_total_index(move))
    end
  end

  def new
    @move = Move.new
  end

  def create
    @move = Move.new(move_params)
    results = Geocoder.search(params[:move][:arrivee])
    @move.arrivee_latitude = results.first.coordinates[0]
    @move.arrivee_longitude = results.first.coordinates[1]
    @move.user = @user
    if @move.save
      # redirection vers la page
      redirect_to add_rooms_move_path(@move)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @move.update(move_params)
      redirect_to @move
    else
      render :edit
    end
  end

  def destroy
    @move.destroy
    redirect_to moves_path
  end

  # method perso evaluat3d

  def add_rooms
  end

  def create_rooms
    params["roomscreation"].each do |room_type, number|
      number = number.to_i
      unless number.zero?
        i = 1
        number.times do
          name = room_type
          name += " #{i}" unless i == 0
          Room.create!(name: name, move_id: @move.id, room_type_id: RoomType.find_by(name: room_type).id)
          i += 1
        end
      end
    end
    redirect_to rooms_list_move_path
  end

  def rooms_list
    @rooms = @move.rooms
  end

  def add_stuffs
    @stuffs = @room.room_type.stuffs
  end

  def create_stuffs
    set_move
    params["stuffscreation"].each do |stuff, number|
      number = number.to_i
      unless number.zero?
        number.times do
          Inventory.create!(room_id: @room.id, stuff_id: Stuff.find_by(name: stuff).id)
        end
      end
    end
    redirect_to rooms_list_move_path(@move)
  end

  def recap
    rooms_list
    @recap = {}
    @rooms.each do |room|
      @recap[room.name] = strip_trailing_zero(volume_stuffs(set_stuffs(room)))
    end
    @volume_total = strip_trailing_zero(volume_total)
    get_tranport
  end

  def details
    @hash_cartons_by_room = {}
    rooms_list
    @cartons = total_cartons(@rooms)
    set_materiels(@cartons)
    @materiels["Transport"] = @move.transport
    @rooms.each do |room|
      @hash_cartons_by_room[room] = carton_room(room)
    end
  end

  def find_mover
  end

  private

  def move_params
    params.require(:move).permit(:depart, :arrivee, :house_type, :acces, :transport, :user_id)
  end

  def set_move
    if params[:move_id].nil?
      @move = Move.find(params[:id])
    else
      @move = Move.find(params[:move_id])
    end
  end

  def set_user
    @user = current_user
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def set_stuffs(room)
    room.stuffs
  end

  def volume_stuffs(stuffs)
    sum = 0.0
    stuffs.each do |stuff|
      sum += stuff.volume
      unless stuff.volume_carton.nil?
        sum += stuff.volume_carton
      end
    end
    sum = sum.ceil(1)
  end

  def volume_total
    unless @rooms.nil?
      sum = 0
      @rooms.each do |room|
        sum += volume_stuffs(set_stuffs(room))
      end
      sum
    end
  end

  def volume_total_index(move)
    unless move.rooms.nil?
      sum = 0
      move.rooms.each do |room|
        sum += volume_stuffs(set_stuffs(room))
      end
      sum
    end
  end

  def total_cartons(rooms)
    cartons = 0
    rooms.each do |room|
      set_stuffs(room).each do |stuff|
        cartons += stuff.carton
      end
    end
    @cartons = cartons
  end

  def carton_room(room)
    cartons_by_room = 0
    set_stuffs(room).each do |stuff|
      cartons_by_room += stuff.carton
    end
    @cartons_by_room = cartons_by_room
  end

  def set_materiels(cartons)
    @materiels = {
      "Dolly" => 1,
      "Charriot" => 1,
      "Sangle" => 4,
      "Rouleaux de bull pack" => 1,
      "Boite à outil" => 1,
      "Rouleaux de scotch" => (cartons / 30.to_f).ceil
    }
  end

  def get_tranport
    rooms_list
    volume = volume_total.ceil
    case volume
    when 0..3
      @move.transport = "Fourgonnette (3m3)"
    when 4..10
      @move.transport = "Fourgon (10m3)"
    when 11..20
      @move.transport = "Petit Camion (20m3)"
    when 21..50
      @move.transport = "Camion (50m3) - NB: Permis Poids Lourds exigé"
    when 51..88
      @move.transport = "Gros Camion remorque (88m3) - NB: Permis Poids Lourds exigé"
    end
    @move.save
  end

  def strip_trailing_zero(number)
    number.to_s.sub(/\.?0+$/, '')
  end
end
