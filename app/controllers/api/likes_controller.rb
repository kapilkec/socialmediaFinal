class Api::LikesController < Api::ApiController
    before_action :is_registered_user

  def createLikeForPost
    post = Post.find_by(id:params[:post_id])
    if post
      like = post.likes.create(user_id: current_user.id )
      if like.save
        render json: {message:"like created"},status: :created
      else
        render json: {message:like.errors.full_messages},status: :uprocessable_entity
      end
    else
      render json: {message:"no post found"},status: :not_found
    end
  end



  def destroyPostLike

    post = Post.find_by(id:params[:post_id])
    if post
      like = post.likes.find_by(id:params[:like_id])
      if like
        if like.destroy
         render json: {message:"like deleted"},status: :see_other
        else
          render json: {message:like.errors.full_messages},status: :unprocessable_entity
        end
      else
         render json: {message:"no like found"},status: :not_found
      end
    else
      render json: {message:"no post available" },status: :not_found
    end

  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
  def is_registered_user
      unless current_user
        p'``````'
        render json: {message: "only registered users can access likes"} ,status: :unauthorized
      end
   end

end
