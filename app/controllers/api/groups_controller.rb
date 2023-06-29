class Api::GroupsController < Api::ApiController
    before_action :is_registered_user, only: [:new,:create,:mygroups,:view]
      before_action :is_group_owner, only: [:delete]
  def show
    groups = Group.all
    if groups
       render json: groups, status: :ok
    else
       render json: {message:"no group found"}, status: :not_found
    end
  end

  def create
    community = Community.find_by(id:params.require(:group)[:category])
    user = User.find_by(id:current_user.id)
    if community and user
      group = Group.new(name:params.require(:group)[:name], bio:params.require(:group)[:bio])
      user.groups << group
      community.groups << group
      if group.save
        if user.save
          if community.save
              render json: {message:"group created"}, status: :created
          else
            render json: {message:community.errors.full_messages},status: :unprocessable_entity
          end
        else
          render json: {message:user.errors.full_messages},status: :unprocessable_entity
        end
      else
        render json: {message:group.errors.full_messages},status: :unprocessable_entity
      end
    else
      render json: {message:"no user or community"}, status: :not_found
    end

  end

  def delete

    group = Group.find_by(id:params[:group_id])
    if group
      if group.destroy
         render json: {message:"group deleted"}, status: :see_other
      else
         render json: {message:group.errors.full_messages},status: :unprocessable_entity
      end
    else
      render json: {message:"unable to find group"}, status: :not_found
    end

  end
  def userWithMoreGroups

    user_with_most_groups = User.joins(:groups)
                              .group(:id)
                              .order('COUNT(groups.id) DESC')
                              .limit(1)
                              .first
    if user_with_most_groups
       render json: user_with_most_groups,status: :ok
    else
      render json: {message:"unable to fetch"},status: :not_found
    end

  end
  private
    def is_group_owner
      group = Group.find_by(params[:group_id])
      unless current_user and current_user == group.user
          render json: {messge: "only group owner can delete"},status: :forbidden
      end
    end

     def is_registered_user
      unless current_user
        render json: {messge: "only registered users can access groups"},status: :unauthorized
      end
    end


end
