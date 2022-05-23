class PostsController < ApplicationController
	
	def index
		#query=params[:q].presence
		#@posts=Post.search(query)
		params[:search_key]
    	@posts = Post.where("body LIKE ?", "%#{params[:search_key]}%")
	end

	def new
		@post = Post.new
	end

	def create
		@user = User.find(@current_user.id)
		@user.posts.create(body: params[:post][:body] , avatar: params[:post][:avatar], status: params[:post][:status])
		redirect_to root_path, notice: 'Successfully Upload'
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@post.update(body: params[:post][:body] , avatar: params[:post][:avatar], status: params[:post][:status])
		redirect_to root_path, notice: 'Successfully Updated!!'
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to root_path, notice: 'Successfully Deleted!!'
	end
end
