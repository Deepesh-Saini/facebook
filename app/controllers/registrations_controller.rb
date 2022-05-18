class RegistrationsController < ApplicationController

  before_action :require_user_logged_in!, only: [:edit, :update]

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

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :date_of_birth, :gender, :avatar)
  end
  
end
