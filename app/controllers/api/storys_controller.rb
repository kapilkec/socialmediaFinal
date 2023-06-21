class Api::StorysController < Api::ApiController
    # before_action :authenticate_user!, only: [:new]
    # before_action :check_story_owner, only: [:delete]
  def index
    storys = Story.not_expired
    render json: storys, status: :ok
  end

  def delete
    p '````````````del```````'
    p params[:id]
    story = Story.find_by(id: params[:id])
    if story and story.destroy
      render json: {message:"story deleted"},status: :ok
    else
      render json: {message: "unable to delete story",status: :ok}
    end
  end

  def create
    user = User.find_by(id:1)
    if user
      story = user.create_story(article_params)
      if story.save
          render json: story, status: :ok
      else
          render json: {message:"unable to create story"}, status: :ok
      end
    else
      render json: {message:"couldn't find user"}, status: :ok
    end
  end

  private
    def article_params
      params.require(:story).permit(:note,:image)
    end
      def check_story_owner
      @story = Story.find(params[:format])

      unless user_signed_in? and current_user.id == @story.user.id
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end

end
