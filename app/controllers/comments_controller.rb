class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post

    if @comment.save
      respond_to :js
    else
      flash[:alert] = "コメントに失敗しました"
    end

    # respond_to do |format|
    #   if @comment.save
    #     format.js
    #   else
    #     flash[:alert] = "コメントに失敗しました"
    #     format.html { redirect_to root_path }
    #   end
    # end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post

    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
  end

  private
  
  def comment_params
    params.required(:comment).permit(:comment, :post_id, :user_id)
  end

end
