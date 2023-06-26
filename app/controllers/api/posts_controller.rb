class Api::PostsController < Api::ApiController

  before_action :is_registered_user, only: [:new,:create,:show, :edit,:update,:destroy]
  before_action :is_post_owner, only: [:edit,:update,:destroy]
  def index
     if current_user
        user = User.find_by(id:current_user.id)
        notification = user.latest_notification
        if notification != nil and notification.hasRead == false
          followedUser = User.find(notification.friend.fromUser)
          flash.now[:notification] = followedUser.name + " is now following you"
        end
     end
    posts = Post.all
    if posts
      if posts.length != 0
        render json: posts, status: :ok
      else
        render json: {message: "no posts" }, status: :ok
      end
    else
       render json: {message:  "posts not available"},status: :not_found
    end
  end

  def show
    post = Post.find_by(id: params[:id])
    if post
      render json: post, status: :found
    else
      render json: {message: "no post found"}, status: :not_found
    end
  end

  def create
    user = User.find_by(id:params[:userId])
    if user
      post = Post.new(post_params)
      user.posts << post
      if post.save
        user.save
        render json: post, status: :created

      else
        render json: {message: post.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {message: "no user found" }, status: :not_found
    end
  end

  def edit

    post = Post.find_by(id:params[:id])
      if post
        render json: post, status: :ok
      else
        render json: {message: "no post found for editing"}, status: :not_found
      end

  end

  def update

      post = Post.find_by(id: params[:id])
      if post
        if post.update(post_params)
            render json: post, status: :ok
        else
          render json: {message: post.errors.full_messages}, status: :unprocessable_entity
        end
      else
        render json: {message: "no post found"}, status: :not_found
      end
  end

  def destroy
    post = Post.find_by(id:params[:id])
    if post
        if post.destroy

          render json: {message:"post deleted" }, status: :see_other

        else
          render json: {message: post.errors.full_messages}, status: :unprocessable_entity
        end
    else
       render json: {message: "no post found"}, status: :not_found
    end
  end
  # custom api
  def postWithZeroLike

    posts_without_likes = Post.left_outer_joins(:likes).where(likes: { id: nil })
    if posts_without_likes
       render json: posts_without_likes,status: :ok
    else
      render json: {message:"unable to fetch"},status: :not_found
    end

  end

  def postWithMoreLikes

   post_with_most_likes = Post.joins(:likes)
                           .group(:id)
                           .order('COUNT(likes.id) DESC')
                           .limit(1)
                           .first
    if post_with_most_likes
       render json: post_with_most_likes,status: :ok
    else
      render json: {message:"unable to fetch"},status: :not_found
    end

  end

  def postWithMoreComments
    post_with_most_comments = Post.joins(:comments)
                              .group(:id)
                              .order('COUNT(comments.id) DESC')
                              .limit(1)
                              .first
    if post_with_most_comments
       render json: post_with_most_comments,status: :ok
    else
      render json: {message:"unable to fetch"},status: :not_found
    end
  end

  private
    def post_params
      # p params[:images]
      params.require(:post).permit(:title, :description,:privacy,:images  )
    end

    def is_post_owner

      post = Post.find_by(id:params[:id])

      unless post and   current_user== post.user

          render json: {message:"only post owner can update or delete"},status: :unauthorized
      end

    end
    def is_registered_user
      unless current_user
         render json: {message: "only registered users can access post"} ,status: :unauthorized
      end
   end

end
