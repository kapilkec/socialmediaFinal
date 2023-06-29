class FriendsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy,:following,:followers,:create]
  def index
    @users = User.all
  end

  def create
    if params[:friend][:fromUser] != current_user.id.to_s
      redirect_to root_path
    else
      record = Friend.new(friend_params)
      notification = Notification.new(user_id: params[:friend][:toUser],friend:record)
      if notification.save
        flash[:alert] = "created"
      else
        flash[:alert] = "unable to create"
      end
      redirect_to allusers_path
    end
  end

  def destroy

    @record = Friend.find_by( id:params[:format])
    unless @record
      flash[:alert] = "no record found"
    else
      if @record.fromUser != current_user.id.to_s
        redirect_to root_path
      else
        @record.followed = false
        if @record.save
          redirect_to allusers_path
        else
          flash[:alert] = "unable to delete"
        end
      end
    end

  end

  def following
    @records = Friend.where(fromUser:current_user.id, followed: true)
  end

  def followers
    @records = Friend.where(toUser:current_user.id, followed: true )
  end
  private
  def friend_params
    params.require(:friend).permit(:fromUser, :toUser)
  end

  def friend_params2
    params.require(:friend).permit(:toUser)
  end



end
