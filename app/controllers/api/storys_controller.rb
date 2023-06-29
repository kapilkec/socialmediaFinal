class Api::StorysController < Api::ApiController
    before_action :is_registered_user, only: [:create]
    before_action :check_story_owner, only: [:delete]
  def index
    storys = Story.not_expired
    render json: storys, status: :ok
  end

  def delete
    story = Story.find_by(id: params[:id])
    if story
      if story.destroy
        render json: {message:"story deleted"},status: :see_other
      else
        render json: {message: story.errors.full_message },status: :unprocessable_entity
      end
    else
      render json: {message:"not found" },status: :not_found
    end

  end


  def create
    user = User.find_by(id:current_user.id)
    if user
      story = user.create_story(article_params)
      if story.save
          render json: story, status: :created
      else
          render json: {message:"unable to create story"},status: :unprocessable_entity
      end
    else
      render json: {message:"couldn't find user"},status: :not_found
    end
  end

  private
    def article_params
      params.require(:story).permit(:note,:image)
    end
      def check_story_owner
      story = Story.find_by(id:params[:id])
      if story == nil
        render json: {message: "story not found"} ,status: :not_found
      else
        unless current_user and current_user == story.user
            render json: {message: "you are not the owner of story"} ,status: :forbidden
        end
      end
    end
     def is_registered_user
      unless current_user
        render json: {message: "only registered users can access stories"} ,status: :unauthorized
      end
   end

end
