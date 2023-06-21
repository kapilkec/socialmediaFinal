class Api::NotificationsController < Api::ApiController
   # before_action :authenticate_user!
  def view
    user = User.find_by(id:1)
    if user
      notifications = user.notifications
      render json: notifications,status: :ok
    else
      render json: {message:"unable to find notification.."},status: :ok
    end
  end

  def markAsRead
    notification = Notification.find_by(id:params[:id])
    if notification and notification.update(hasRead: true)
      render json: { message: "marked as read" }
    else
      render json: {message: "unable to mark as read" }
    end
  end
end
