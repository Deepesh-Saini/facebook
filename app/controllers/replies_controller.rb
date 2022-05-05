class RepliesController < ApplicationController
  
  def new
    @comments = Comment.find(params[:comment_id])
    @comment = @comments.comments.new
  end


  def create
    @comments = Comment.find(params[:comment_id])
    @comment = @comments.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to root_path, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

end
