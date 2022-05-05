class SessionsController < ApplicationController

    def create
      @user = User.find_by(email: params[:email])
      # finds existing user, checks to see if user can be authenticated
      if @user.present? && @user.authenticate(params[:password])
      # sets up user.id sessions
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Successfully Logged In'
      else
        redirect_to root_path, notice: 'Invalid email or password'
      end
    end

    
    def destroy
      # deletes user session
      session[:user_id] = nil
      redirect_to root_path, notice: 'Successfully Logged Out'
    end
    
end
