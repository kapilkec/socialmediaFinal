class StorysController < ApplicationController
  def index
    @storys = Story.all
  end

  def delete
    @story = Story.find(params[:format])
    @story.destroy
    redirect_to storys_path
  end

  def new
    @story = Story.new
  end

  def create
    @user = User.find(2)

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
end
