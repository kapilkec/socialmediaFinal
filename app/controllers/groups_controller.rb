class GroupsController < ApplicationController
  def show
    @groups = Group.all

  end
  def new
    @communitys = Community.all
    @group = Group.new
  end
  def create
    @community = Community.find(params.require(:group)[:category])
    @user = User.find(1)
    @group = Group.new(name:params.require(:group)[:name], bio:params.require(:group)[:bio])
    @user.groups << @group
    @community.groups << @group
    @group.save
    @user.save
    @community.save

    redirect_to groups_path
  end

  def mygroups
    @userid = 1
    @members = Member.all.where(user_id:@userid)

  end

  def delete
    p '````````````````````'
    @group = Group.find(params[:group_id])
    @group.destroy
    redirect_to groups_mygroups_path
  end

  def view
    p'``````````````````````'
    @group = Group.find(params[:id])
    
  end

end
