class WelcomeController < ApplicationController
  skip_before_action :require_user_logged_in!

  def index
    if Rails.env.production?
      @country = request.location.country
      @city = request.location.city
    end
    #Query = params[:q].presence || “*”
      #@posts = Post.search(
        #query,
          #page: params[:page}, per_page: 25
        #)
      @posts = Post.order(created_at: :desc)
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