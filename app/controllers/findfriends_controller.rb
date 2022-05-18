class FindfriendsController < ApplicationController

  def index
    if params[:search_key]
      @users = User.where("first_name LIKE ?", "%#{params[:search_key]}%")
    else
      @users = User.all
    end
  end

  def sent_requests
    @friends = Friend.where(sender_id: @current_user.id)
  end

  def receive_requests
    receive_requests = Friend.where(user_id: @current_user.id)
    @friends = receive_requests.where(friends: "false")
  end
  
end
