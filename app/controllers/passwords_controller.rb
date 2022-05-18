class PasswordsController < ApplicationController

  def update
    if @current_user.update(password_params)
      redirect_to root_path, notice: 'Password Update Successfully.'
    else
      redirect_to root_path, notice: 'Something went wrong.'
    end
  end

    
  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
