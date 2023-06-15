class PostsController < ApplicationController
  before_action :authenticate_deviseuser!
  def index
    @posts = Post.all
  end
  def show
    @post = Post.find(params[:id])
  end
  def new
    @post = Post.new
  end
  def create
    p "ctrh``````````````````````````"
    @user = User.find(1)
    @post = Post.new(post_params)
    @user.posts << @post
    if @post.save

      @user.save
      redirect_to  posts_path
    else
      render :new, status: :unprocessable_entity
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
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end
  private
    def post_params
      params.require(:post).permit(:title, :description, images:[])
    end

end
