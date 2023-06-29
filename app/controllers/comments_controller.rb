class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_comment_owner, only: [:edit,:update]
  before_action :is_post_owner, only:[:destroy]

  def edit
    @post = Post.find_by(id:params[:post_id])
    if @post
        @comment = @post.comments.find_by(id:params[:id])
    end
    unless @post and @comment
      redirect_to root_path
    end
  end

  def update

    @post = Post.find_by(id:params[:post_id])
    @comment = @post.comments.find_by(id:params[:id])
    if @comment.update(comment_params)
      flash[:updateSuccess] = "created.."
      redirect_to  post_path(params[:post_id])
    else
      render :edit, status: :unprocessable_entity
    end

  end

   def create
    @user = User.find_by(id:current_user.id)
    @post = Post.find_by(id: params[:post_id])
    if @post == nil
      redirect_to root_path
    else
      param =  params.require(:comment)
      @comment = Comment.new(commenter: param[:commenter], comment: param[:comment], user_id: @user.id)
      @post.comments << @comment
      if @comment.save
        @post.save
      else
        flash[:createError] = "unable to create"
        flash[:error] = "comment" + @comment.errors[:comment][0]
      end
      flash[:createSuccess] = "created.."
      redirect_to post_path(:post_id)
    end



  end

   def destroy
    @post = Post.find_by(id:params[:post_id])
    if @post == nil
      redirect_to root_path
    else
      @comment = @post.comments.find_by(id:params[:id])
      if @comment.destroy
        flash[:deleteSuccess] = "deleted.."
      else
        flash[:deletefailure] = "unable to delete.."
      end
      redirect_to post_path(:post_id)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :comment)
    end

    def is_comment_owner

      @comment = Comment.find_by(id: params[:id])

      unless @comment and user_signed_in? and current_user == @comment.user

          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end

    def is_post_owner
      @comment = Comment.find_by(id:params[:id])
      unless (user_signed_in? and current_user.id == @comment.post.user.id) or (current_user.id == @comment.user.id)
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end

end
