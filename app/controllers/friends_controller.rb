class FriendsController < ApplicationController
	before_action :find_user, except: [:destroy]
	before_action :find_request, only: [:destroy]

  def show
    @receive_requests_friends = @user.friends.where(friends: "true" )
    @sent_requests_friends = Friend.where(sender_id: @user.id)
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
    @friend = Friend.find_by_id(params[:id])
    @friend.update(friends: "true")
    redirect_to registrations_path
  end

  private
  def find_user
    @user = User.find_by_id(params[:id])
  end

  def already_requested?
    Friend.where(sender_id: @current_user.id, user_id: params[:user_id]).exists?
  end

  def find_request
    @request = Friend.find(params[:id])
  end
end