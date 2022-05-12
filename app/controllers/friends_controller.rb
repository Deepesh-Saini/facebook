class FriendsController < ApplicationController
	before_action :find_user, only: [:create, :update, :destroy]
	before_action :find_request, only: [:destroy]
  before_action :require_user_logged_in!

  def index
    @friends = Friend.where(sender_id: @current_user.id)
  end

	def create
		if already_requested?
      flash[:notice] = "Request already sent."
    else	
    @friend = @user.friends.create(sender_id: @current_user.id)
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
    @friend = @user.friends.find_by_id(params[:id])
    @friend.update(friends: "true")
    redirect_to receive_requests_registration_path(@current_user.id)
  end

  


  private
  def find_user
    @user = User.find_by_id(params[:registration_id])
  end

  def already_requested?
  Friend.where(sender_id: @current_user.id, user_id: params[:user_id]).exists?
  end

  def find_request
   @request = @user.friends.find(params[:id])
  end

end
