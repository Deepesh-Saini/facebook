class WelcomeController < ApplicationController

  def index
    if params[:search_key]
      @post = Post.where("body LIKE ?", "%#{params[:search_key]}%")
    else
      @post = Post.order(created_at: :desc)
    end
    @user = User.all
    @comment = Comment.new    
  end

  def show
    @user = User.find(Current.user.id)
    @post = Post.where(user_id: Current.user.id)
  end

end
