class RegistrationsController < ApplicationController

  def index
    if params[:search_key]
      @users = User.where("first_name LIKE ?", "%#{params[:search_key]}%")
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@user, @current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
    @messages = @single_room.messages

    render "rooms/index"
  end

  private
  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      SignupMailer.with(user: @user).signup_email.deliver_later
      redirect_to root_path, notice: 'Successfully created account. Please confirm your email address within 5 minutes to continue.'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(confirm_token: SecureRandom.urlsafe_base64.to_s)
      SignupMailer.with(user: @user).signup_email.deliver_later
      redirect_to root_path, notice: 'Verification link has been sent successfully.'
    else
      render :new
    end
  end

  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      if Time.now - @user.updated_at < 300
        @user.email_activate
        redirect_to root_path, notice: "Welcome to the Sample App! Your email has been confirmed. Please sign in to continue."
      else
        redirect_to edit_registration_path(@user)
      end
    else
      redirect_to root_url, notice: "Sorry. User does not exist"
    end
  end

  def sent_requests
    @friends = Friend.where(sender_id: @current_user.id)
  end

  def receive_requests
    receive_requests = Friend.where(user_id: @current_user.id)
    @friends = receive_requests.where(friends: "false")
  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :date_of_birth, :gender, :avatar)
  end
  
end
