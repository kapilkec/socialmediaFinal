class FriendsController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @record = Friend.new(friend_params)
    @record.save
    redirect_to allusers_path
  end

  def destroy
    @record = Friend.find( params[:format])
    @record.destroy
    redirect_to allusers_path
  end

  def following
    @records = Friend.where(fromUser:1)
  end

  def followers
    @records = Friend.where(toUser:1)
  end

  def friend_params
    params.require(:friend).permit(:fromUser, :toUser)
  end

end
