class GroupsController < ApplicationController
    before_action :authenticate_user!, only: [:new,:create,:delete,:mygroups,:join,:view]
    before_action :is_group_owner, only: [:delete]

  def show
    @groups = Group.all
  end
  def new
    @communitys = Community.all
    @group = Group.new
  end
  def create
    @communitys = Community.all
    @community = Community.find_by(id:params.require(:group)[:category])
    if @community == nil
      redirect_to root_path
    else
      @user = User.find_by(id:current_user.id)
      @group = Group.new(name:params.require(:group)[:name], bio:params.require(:group)[:bio])
      @user.groups << @group
      @community.groups << @group
      if @group.save
        @user.save
        @community.save
        redirect_to groups_path
      else
        render :new, status: :unprocessable_entity
      end
    end

  end

  def mygroups

    @members = Member.all.where(user_id:User.find(current_user.id))

  end

  def delete
    @group = Group.find_by(id:params[:group_id])
    if @group and @group.destroy
      redirect_to groups_mygroups_path
    else
      redirect_to root_path
    end
  end

  def view
    @group = Group.find_by(id:params[:id])
    if @group == nil
      redirect_to root_path
    end

  end

  def join

   @group = Group.find_by(id:params[:group_id])
    if @group == nil
      redirect_to root_path
    end
  end

  private
    def is_group_owner
      @group = Group.find_by(id:params[:group_id])
      unless @group and user_signed_in? and current_user.id == @group.user.id
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end


end
