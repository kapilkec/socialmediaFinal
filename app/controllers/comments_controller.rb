class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_comment_owner, only: [:edit,:update]
  before_action :is_post_owner, only:[:destroy]
  def edit
     @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

    def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

     if @comment.update(comment_params)
      redirect_to  post_path(params[:post_id])
    else
      render :edit, status: :unprocessable_entity

  end
end

   def create
    p '``````````````````````````````'
    @user = User.find(current_user.id)
    @post = Post.find(params[:post_id])
    param =  params.require(:comment)
    @comment = Comment.new(commenter: param[:commenter], comment: param[:comment], user_id: @user.id)
    @post.comments << @comment
    @comment.save
    @post.save
    redirect_to post_path(:post_id)
  end
   def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(:post_id)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :comment)
    end
    def is_comment_owner
      @comment = Comment.find(params[:id])
      unless user_signed_in? and current_user.id == @comment.user.id 
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end
     def is_post_owner
      @comment = Comment.find(params[:id])
      unless (user_signed_in? and current_user.id == @comment.post.user.id) or (current_user.id == @comment.user.id)
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end
end
