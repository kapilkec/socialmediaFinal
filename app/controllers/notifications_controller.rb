class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def view
    user = User.find(current_user.id)
    @notifications = user.notifications
  end
  def markAsRead
    notification = Notification.find(params[:id])
    notification.hasRead = true
    notification.save
    redirect_to notifications_all_path
  end
end
