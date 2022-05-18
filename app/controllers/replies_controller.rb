class RepliesController < ApplicationController

  def create
    @comments = Comment.find(params[:comment_id])
    @comment = @comments.comments.new(comment_params)

    if @comment.save
      redirect_to root_path, notice: "Comment was successfully created."
    else
      redirect_to root_path, notice: 'Something went wrong. Please try again!'
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end