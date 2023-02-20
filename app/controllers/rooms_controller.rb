class RoomsController < ApplicationController
  before_action :single_room, only: [:show]
  before_action :rooms, only: [:index, :show]
  before_action :users, only: [:index, :show]

  def index
    @room = Room.new

    render 'index'
  end

  def show
    @message  = Message.new
    @messages = single_room.messages.order(created_at: :asc)
    @room     = Room.new

    render 'index'
  end

  def create
    @room = Room.create(room_params)
  end

  private

  def single_room
    @single_room ||= Room.find(params[:id])
  end

  def users
    @users ||= User.all_except(current_user)
  end

  def rooms
    @rooms ||= Room.public_rooms
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
