class SessionsController < ApplicationController
  skip_before_action :require_user_logged_in!

  def create
    @user = User.find_by(email: params[:email])

    if @user.present? && @user.authenticate(params[:password])
      if @user.email_confirmed
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Successfully Logged In'
      else
        redirect_to root_path, notice: 'Please activate your account by following the 
        instructions in the account confirmation email you received to proceed'
      end
    else
      redirect_to root_path, notice: 'Invalid email or password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Successfully Logged Out'
  end
end
