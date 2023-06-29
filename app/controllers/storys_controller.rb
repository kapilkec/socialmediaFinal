class StorysController < ApplicationController
    before_action :authenticate_user!, only: [:create,:new,:delete]
    before_action :check_story_owner, only: [:delete]
  def index
    @storys = Story.not_expired

  end

  def delete
    @story = Story.find_by(id:params[:format])
    if @story
      @story.destroy
      redirect_to storys_path
    else
      flash[:notice] = "no record found"
      redirect_to root_path
    end
  end

  def new
    @story = Story.new
  end

  def create
    @user = User.find_by(id:current_user.id)

    @story = @user.create_story(article_params)

    if @story.save
      redirect_to storys_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def article_params
      params.require(:story).permit(:note,:image)
    end
      def check_story_owner
      @story = Story.find_by(id:params[:format])
      if @story == nil
        flash[:alert] = "no record found"
        redirect_to root_path
      else
        unless @story and user_signed_in? and current_user.id == @story.user.id
            flash[:notice] = "Unauthorized access"
            redirect_to root_path
        end
      end
    end

end
