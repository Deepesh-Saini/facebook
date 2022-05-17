class RoomsController < ApplicationController
  
  def index
    redirect_to root_path unless @current_user
    @users = User.all_except(@current_user)
    @room = Room.new
  end

  def show
    @user = User.find(params[:id])
    @users = User.all_except(@current_user)
    @message = Message.new
    @room_name = get_name(@user, @current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
    @messages = @single_room.messages

    render "index"
  end

  private
  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end

end
