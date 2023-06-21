class Api::LikesController < Api::ApiController
    # before_action :authenticate_user!
  def createLikeForPost
    post = Post.find_by(id:params[:post_id])
    if post
      like = post.likes.create(user_id: 1)
      if like.save
      render json: {message:"like created"},status: :ok
      end
    else
      render json: {message:"unable to create like"},status: :ok
    end
  end



  def destroyPostLike

    post = Post.find_by(id:params[:post_id])
    if post
      like = post.likes.find_by(id:params[:like_id])
      if like
         like.destroy
         render json: {message:"like deleted"},status: :ok
      else
         render json: {message:"unable to Delete like"},status: :ok
      end
    else
      render json: {message:"no post available" },status: :ok
    end

  end



  def like_params
    params.require(:like).permit(:post_id)
  end
end
