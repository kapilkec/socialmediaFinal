class FriendsController < ApplicationController
  before_action :authenticate_user!, only: [:following,:followers]

  def index
    @users = User.all
  end

  def create
    record = Friend.new(friend_params)
    notification = Notification.new(user_id: params.require(:friend)[:toUser])
    record.notification = notification
    record.save

    notification.save
    redirect_to allusers_path
  end

  def destroy
    @record = Friend.find( params[:format])
    @record.followed = false
    @record.save
    redirect_to allusers_path
  end

  def following
    @records = Friend.where(fromUser:current_user.id, followed: true)
  end

  def followers
    @records = Friend.where(toUser:current_user.id, followed: true )
  end

  def friend_params
    params.require(:friend).permit(:fromUser, :toUser)
  end

  def friend_params2
    params.require(:friend).permit(:toUser)
  end

end
