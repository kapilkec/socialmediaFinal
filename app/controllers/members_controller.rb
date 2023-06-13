class MembersController < ApplicationController
  def create
    param = params.require(:member)
    @user = User.first
    p '``````````````'
    p param[:group_id]
    @group = Group.find(param[:group_id].to_i)
    p @group

    @member = Member.new( interestRating: param[:rating], user:@user)

    @group.members << @member
    @member.save
    @group.save
    redirect_to groups_path
  end
end
