class Api::PostsController < Api::ApiController

  # before_action :authenticate_user!, only: [:new,:create,:show, :edit,:update,:destroy]
  # before_action :is_post_owner, only: [:edit,:update,:destroy]
  def index
     if user_signed_in?
        user = User.find(current_user.id)
        notification = user.latest_notification
        if notification != nil and notification.hasRead == false
          followedUser = User.find(notification.friend.fromUser)
          flash.now[:notification] = followedUser.name + " is now following you"
        end
     end
    posts = Post.all
    if posts.length != 0
      render json: posts, status: :ok
    else
      render json: {message: "no posts" }, status: :ok
    end
  end

  def show
    post = Post.find_by(id: params[:id])
    if post
      render json: post, status: :ok
    else
      render json: {message: "no post found"}, status: :ok
    end
  end

  def new
    @post = Post.new
  end
  def create
    p "ctrh``````````````````````````"
    user = User.last


    post = Post.new(post_params)

    user.posts << post
    if post.save
      user.save
      render json: post, status: :ok

    else
      render json: {message: "unable to create"}, status: :ok
    end
  end

  def edit

    @post = Post.find(params[:id])
  end

    def update

    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to  posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
     if post.destroy

      render json: {message:"post deleted" }, status: :ok

    else
      render json: {message: "unable to create"}, status: :ok
    end


     
  end
  private
    def post_params
      # p params[:images]
      params.require(:post).permit(:title, :description,:privacy,:images  )
    end

    def is_post_owner
      @post = Post.find(params[:id])
      unless user_signed_in? and current_user.id == @post.user.id
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end

end
