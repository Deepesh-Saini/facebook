class FriendsController < ApplicationController
	before_action :find_receiver, only: [:create]
	before_action :find_request, only: [:destroy]

  def index
    @receive_requests_friends = @current_user.friends.where(friends: "true")
    @sent_requests_friends = Friend.where(sender_id: @current_user.id).where(friends: "true")
  end

	def create
		if already_requested?
      flash[:notice] = "Request already sent."
    else	
      @friend = @receiver_user.friends.create(sender_id: @current_user.id)
      redirect_to registrations_path
    end
  end

  def destroy
    if already_requested?
      flash[:notice] = "Cannot send request"
    else
      @request.destroy
    end
    redirect_to registrations_path
  end

  def update
    @friend = Friend.find_by_id(params[:id])
    @friend.update(friends: "true")
    redirect_to registrations_path
  end

  private
  def find_receiver
    @receiver_user = User.find_by_id(params[:id])
  end

  def already_requested?
    Friend.where(sender_id: @current_user.id, user_id: params[:user_id]).exists?
  end

  def find_request
    @request = Friend.find(params[:id])
  end
end