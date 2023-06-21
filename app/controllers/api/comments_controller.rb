class Api::CommentsController < Api::ApiController
  # before_action :authenticate_user!
  # before_action :is_comment_owner, only: [:edit,:update]
  # before_action :is_post_owner, only:[:destroy]
  def index
    post = Post.find_by(id: params[:post_id])
    if post
        comments = post.comments.all
        render json: comments, status: :ok
    else
      render json: {message:"unable to create"},status: :ok
    end
  end

  def edit
     @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    user = User.find_by(id:2)
    post = Post.find_by(id: params[:post_id] )

    if post == nil or user==nil
        render json: {message:"no user or post found"},status: :ok
    else
      comment = post.comments.find_by(id: params[:id])

     if comment!=nil and comment.update(comment_params)
        render json: comment, status: :ok
    else
        render json: {message:"unable to update"},status: :ok
     end
    end
end

  def create

    p params[:post_id]
    user = User.find_by(id:2)
    post = Post.find_by(id: params[:post_id] )
    p post
    if post == nil or user==nil
        render json: {message:"no user or post found"},status: :ok
    else
        param =  params.require(:comment)
        comment = Comment.new(commenter: param[:commenter], comment: param[:comment], user_id: user.id)
        post.comments << comment
        if  comment.save
          if post.save
              render json: comment, status: :ok
          else
              render json: {message:"unable to create comment for this post"},status: :ok
          end
        else
          render json: {message:"unable to create comment"},status: :ok
        end
    end
  end


   def destroy
    post = Post.find_by(id:params[:post_id])
    if post
      comment = post.comments.find_by(id:params[:id])
      if comment
         comment.destroy
         render json: {message:"comment deleted"}, status: :ok
      else
        render json: {message:"unable to  delete"}, status: :ok
      end
    else
        render json: {message:"No post found"}, status: :ok
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :comment)
    end
    def is_comment_owner
      @comment = Comment.find(params[:id])
      unless user_signed_in? and current_user.id == @comment.user.id
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end
     def is_post_owner
      @comment = Comment.find(params[:id])
      unless (user_signed_in? and current_user.id == @comment.post.user.id) or (current_user.id == @comment.user.id)
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end
end
