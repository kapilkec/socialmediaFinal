class Api::GroupsController < Api::ApiController
    # before_action :authenticate_user!, only: [:new,:create,:mygroups,:view]
    #   before_action :is_group_owner, only: [:delete]
  def show
    groups = Group.all
    render json: groups, status: :ok
  end

  def create
    community = Community.find_by(id:params.require(:group)[:category])
    user = User.find_by(id:1)
    if community and user
      group = Group.new(name:params.require(:group)[:name], bio:params.require(:group)[:bio])
      user.groups << group
      community.groups << group
      if group.save and user.save and community.save
        render json: {message:"group created"}, status: :ok
      else
        render json: {message:"failed to create group"}, status: :ok
      end
    else
      render json: {message:"no user or community"}, status: :ok
    end

  end

  def delete
    p '`````````delte group```````````'
    group = Group.find_by(id:params[:group_id])
    if group and group.destroy
      render json: {message:"group deleted"}, status: :ok
    else
      render json: {message:"unable to delete group"}, status: :ok
    end

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
