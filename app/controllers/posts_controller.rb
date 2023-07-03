class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new,:create,:show, :edit,:update,:destroy]
  before_action :is_post_owner, only: [:edit,:update,:destroy]
  def index
     if user_signed_in?
        user = User.find_by(id:current_user.id)
        notification = user.latest_notification
        if notification != nil and notification.hasRead == false
          followedUser = User.find(notification.friend.fromUser)
          flash.now[:notification] = followedUser.name + " is now following you"
        end
     end

    allposts = Post.all

    @flag = false
    unless params[:field]
      p 'gfhj1````````````'
        @flag = true
        @posts=Post.includes(:user,:likes,:comments).page(params[:page])
    else
        @posts = Array.new
        allposts.each do |post|
            @posts.push(post)
        end
        if  params[:field] and params[:field] == "Name" and params[:value].length!=0
          @posts = filter_posts_by_user_name(Post.all, /^#{params[:value]}/)
        end
        if  params[:field] and params[:field] == "Title" and params[:value].length!=0
          @posts = @posts.select{ |post| post[:title] =~ /#{params[:value]}/ }
          p '````````21'
          p @posts
        end
        if  params[:field] and params[:field] == "Description" and params[:value].length!=0
          @posts =  @posts.select{ |post| post[:description] =~ /#{params[:value]}/ }
        end
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  def new
    @post = Post.new
  end
  def create
    @user = User.find(current_user.id)
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

    @post = Post.find_by(id:params[:id])

    if  @post != nil and @post.destroy
      redirect_to root_path, status: :see_other
    else
      redirect_to root_path, notice:"unable to destroy.."
    end


  end

  private
    def post_params
      params.require(:post).permit(:title, :description,:privacy, images:[])
    end
    def is_post_owner
      @post = Post.find_by(id:params[:id])
      unless @post and user_signed_in? and current_user.id == @post.user.id
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end
    def filter_posts_by_user_name(posts, pattern)
      posts.select { |post| post.user.name =~ pattern }
    end

end
