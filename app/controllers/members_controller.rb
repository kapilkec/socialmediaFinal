class MembersController < ApplicationController
  before_action :is_not_owner, only: [:create]
  def create
    @param = params.require(:member)
    @user = User.find(current_user.id)
    p '``````````````'
    p @param[:group_id]
    @group = Group.find(@param[:group_id])
    p @group

    @member = Member.new( interestRating: @param[:rating], user:@user)

    @group.members << @member
    @member.save
    @group.save
    redirect_to groups_path
  end
  private

      def is_not_owner
         param = params.require(:member)
      @group = Group.find(param[:group_id])
      unless user_signed_in? and current_user.id != @group.user.id
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
      end
    end

end
