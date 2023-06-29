class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def view
    user = User.find_by(id:current_user.id)
    @notifications = user.notifications
  end
  def markAsRead
    notification = Notification.find_by(id: params[:id])
    if notification== nil
       flash[:notice] = "no notification found"
       redirect_to root_path
    else
      if current_user and current_user.id == notification.user.id
        notification.hasRead = true
        notification.save
        redirect_to notifications_all_path
      else
        flash[:notice] = "not a notification owner"
        redirect_to root_path
      end
    end
  end


end
