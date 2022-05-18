class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :require_user_logged_in!

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
    
  def require_user_logged_in!
    redirect_to root_path, notice: 'You must be signed in.' unless @current_user
  end
end