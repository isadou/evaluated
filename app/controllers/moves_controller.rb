class MovesController < ApplicationController
  before_action :set_move, only: [:show, :destroy, :update, :edit]
  before_action :set_user, only: [:new, :create]
  before_action :set_room, only: [:new, :create, :add_stuffs]

  # method crud
  def index
  end

  def new
    @move = Move.new
  end

  def create
    @move = Move.new(move_params)
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
    redirect_to root_path
  end

  # method perso evaluat3d

  def add_rooms
  end

  def create_rooms
  end

  def rooms_list
    @rooms = @move.rooms
  end

  def add_stuffs
    @stuffs = @room.room_type.stuffs
  end

  def create_stuffs
  end

  def recap
  end

  def details
  end

  def find_mover
  end

  private

  def move_params
    params.require(:move).permit(:depart, :arrivee, :house_type, :acces, :transport, :user_id)
  end

  def set_move
    @move = Move.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
