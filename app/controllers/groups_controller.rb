class GroupsController < ApplicationController
    before_action :authenticate_user!, only: [:new,:create,:mygroups,:view]
      before_action :is_group_owner, only: [:delete]
  def show
    @groups = Group.all
  end
  def new
    @communitys = Community.all
    @group = Group.new
  end
  def create
    @community = Community.find(params.require(:group)[:category])
    @user = User.find(current_user.id)
    @group = Group.new(name:params.require(:group)[:name], bio:params.require(:group)[:bio])
    @user.groups << @group
    @community.groups << @group
    @group.save
    @user.save
    @community.save

    redirect_to groups_path
  end

  def mygroups

    @members = Member.all.where(user_id:User.find(current_user.id))

  end

  def delete
    p '`````````delte group```````````'
    @group = Group.find(params[:group_id])
    @group.destroy
    redirect_to groups_mygroups_path
  end

  def view
    p'``````````view group````````````'
    @group = Group.find(params[:id])

  end

  def join
    p '`````````join````````'
   @group = Group.find(params[:group_id])
   puts @group.name
  end

  private
    def is_group_owner
      @group = Group.find(params[:group_id])
      unless user_signed_in? and current_user.id == @group.user.id
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end


end
