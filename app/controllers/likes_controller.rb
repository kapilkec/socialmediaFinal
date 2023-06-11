class LikesController < ApplicationController
  def createLikeForPost
    @post = Post.find(params[:post_id])

    @user=User.first
    @like = @post.likes.create(user: @user)

    if !@like.save
      flash[:alert] = "Already liked"
    end

    redirect_to root_path
  end

  def createLikeForComment
    @comment = Comment.find(params[:comment_id])

    @user=User.first
    @like = @comment.likes.create(user: @user)

    if !@like.save
      flash[:alert] = "Already liked"
    end

    redirect_to root_path
  end


  def destroyPostLike

    @post = Post.find(params[:post_id])

    @like = @post.likes.find(params[:like_id])
    @like.destroy
    redirect_to root_path
  end

  def deleteCommentLike

    @comment = Comment.find(params[:comment_id])

    @lik = @comment.likes.find(params[:like_id])
    
    @lik.destroy
    redirect_to root_path
  end

  def like_params
    params.require(:like).permit(:post_id)
  end
end
