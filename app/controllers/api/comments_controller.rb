class Api::CommentsController < Api::ApiController
  before_action :is_comment_owner, only: [:edit,:update]
  before_action :is_registered_user
  before_action :is_post_owner,only: [:destroy]

  def index
    post = Post.find_by(id: params[:post_id])
    if post
        comments = post.comments.all
        unless comments.empty?
           render json: comments, status: :found
        else
            render json: {message: "unable to fetch comments"}, status: :not_found
        end
    else
         render json: {message: "no post found"}, status: :not_found
    end
  end



def update
    user = User.find_by(id:current_user.id)
    post = Post.find_by(id: params[:post_id] )

    if post == nil or user==nil
        render json: {message:"no user or post found"},status: :not_found
    else
        comment = post.comments.find_by(id: params[:id])
        if comment
          if comment.update(comment_params)
              render json: comment, status: :ok
          else
              render json: {message:comment.errors.full_messages},status: :unprocessable_entity
          end
        else
          render json: {message: "no comment found"}, status: :not_found
        end
    end
end

  def create


    user = User.find_by(id:current_user.id)
    post = Post.find_by(id: params[:post_id] )

    if post == nil or user==nil
        render json: {message:"no user or post found"},status: :not_found
    else
        param =  params.require(:comment)
        comment = Comment.new(commenter: param[:commenter], comment: param[:comment], user_id: user.id)
        post.comments << comment
        if  comment.save
          if post.save
              render json: comment, status: :created
          else
              render json: {message:post.errors.full_messages},status: :unprocessable_entity
          end
        else
          render json: {message:comment.errors.full_messages},status: :unprocessable_entity
        end
    end
  end


   def destroy
    post = Post.find_by(id:params[:post_id])
    if post
      comment = post.comments.find_by(id:params[:id])
      if comment
         if comment.destroy
            render json: {message:"comment deleted"}, status: :see_other
         else
            render json: {message:comment.errors.full_messages},status: :unprocessable_entity
         end
      else
        render json: {message:"no commnents found"}, status: :not_found
      end
    else
        render json: {message:"No post found"}, status: :not_found
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :comment)
    end

    def is_comment_owner
      comment = Comment.find_by(id:params[:id])
      unless comment and current_user and  current_user == comment.user
          render json:{message:"only owner can update or delete"},status: :forbidden
      end
    end

    def is_post_owner

      comment = Comment.find_by(id:params[:id])
      unless (user_signed_in? and current_user == comment.post.user) or (current_user == comment.user)
          flash[:notice] = "Unauthorized access"
          render json: {messge: "only registered users can access comments"},status: :unauthorized
      end
    end

    def is_registered_user
      unless current_user
        render json: {messge: "only registered users can access comments"},status: :unauthorized
      end
    end

end
