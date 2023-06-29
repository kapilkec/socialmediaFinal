class LikesController < ApplicationController
  before_action :authenticate_user!
  def createLikeForPost
    @post = Post.find_by(id:params[:post_id])
    if @post == nil
      redirect_to root_path
    else
      @like = @post.likes.create(user_id: current_user.id)

      if @like.save
         flash[:alert] = "like saved"
      else
        flash[:alert] = "unable to save like"
      end
      redirect_to root_path
    end
  end

  def createLikeForComment

    @comment = Comment.find_by(id:params[:comment_id])
    if @comment == nil
      redirect_to root_path
    else
      @user=User.find_by(id: current_user.id)
      @like = @comment.likes.create(user: @user)

      if @like.save
        flash[:alert] = "like saved"
      else
        flash[:alert] = "unable to save like"
      end

      redirect_to post_path(params[:post_id])
    end
  end


  def destroyPostLike

    @post = Post.find_by(id:params[:post_id])
    if @post == nil
      redirect_to root_path
    else
      @like = @post.likes.find_by(id:params[:like_id])
      if @like == nil
        flash[:alert] = "no like record found"
      else
        @like.destroy
        flash[:alert] = "like deleted"
      end
      redirect_to root_path
    end
  end

  def deleteCommentLike


    @comment = Comment.find_by(id:params[:comment_id])
    if @comment == nil
      redirect_to root_path
    else
      @like = @comment.likes.find_by(id:params[:like_id])
      if @like == nil
        flash[:alert] = "no like record found"
      else
        @like.destroy
        flash[:alert] = "like deleted"
      end
    end
  end

  def like_params
    params.require(:like).permit(:post_id)
  end
end
