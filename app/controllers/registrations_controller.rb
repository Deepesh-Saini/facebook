class RegistrationsController < ApplicationController
	def new
      @user = User.new
    end

    def create
    @user = User.new(user_params)
    if @user.save
      # deliver_now is provided by ActiveJob.
      redirect_to root_path, notice: 'Successfully created account'
    else
      render :new
    end
  end

    
    private
    # strong parameters
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :date_of_birth, :gender, :avatar)
    end
end
