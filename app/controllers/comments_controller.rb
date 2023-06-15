class CommentsController < ApplicationController

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
    @user = User.find(1)
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
end
