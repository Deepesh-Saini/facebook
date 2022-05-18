class WelcomeController < ApplicationController
  skip_before_action :require_user_logged_in!

  def index
    if params[:search_key]
      @posts = Post.where("body LIKE ?", "%#{params[:search_key]}%")
    else
      @posts = Post.order(created_at: :desc)
    end
  end

  def show
    if @current_user
      @user = User.find(@current_user.id)
      @posts = Post.where(user_id: @current_user.id).order(created_at: :desc)
    else
      redirect_to root_path, notice: "Please Login first."
    end
  end

end
