class PostsController < ApplicationController

	before_action :require_user_logged_in!

	def new
		@post = Post.new
	end

	def create
		@user = User.find(@current_user.id)
		@post = @user.posts.create(body: params[:post][:body] , avatar: params[:post][:avatar], status: params[:post][:status])
      # deliver_now is provided by ActiveJob.
      redirect_to root_path, notice: 'Successfully Upload'
	end

	def show
		@post = Post.all.find(params[:id])
		Like.create(user_id: @current_user.id, post_id: @post.id)
		redirect_to post_path(@post)
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@user = User.find(@current_user.id)
		@post = @user.posts.create(body: params[:post][:body] , avatar: params[:post][:avatar], status: params[:post][:status])
      # deliver_now is provided by ActiveJob.
      redirect_to root_path, notice: 'Successfully Updated!!'
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to root_path, notice: 'Successfully Deleted!!'
	end
end
