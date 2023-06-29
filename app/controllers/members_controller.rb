class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_not_owner, only: [:create]
  def create
    param = params.require(:member)
    @user = User.find_by(id:current_user.id)
    @group = Group.find_by(id:param[:group_id])
    if @group
      @member = Member.new( interestRating: param[:rating], user:@user)
      @group.members << @member
      if @member.save and  @group.save
        redirect_to groups_path
      else
        redirect_to root_path
      end
    else
      flash[:notice] = "no group found"
      redirect_to root_path
    end
  end
  private

      def is_not_owner
         param = params.require(:member)
         @group = Group.find_by(id:param[:group_id])

       unless @group and user_signed_in? and current_user.id != @group.user.id
          if @group == nil
            flash[:alert] = "no group found"
          end
          flash[:notice] = "Unauthorized access"
          redirect_to root_path
       end
    end

end
