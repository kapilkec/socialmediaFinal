class Api::NotificationsController < Api::ApiController
   before_action :is_registered_user
  def view
    user = User.find_by( id:current_user.id )
    if user
      notifications = user.notifications
      render json: notifications,status: :ok
    else
      render json: {message:"unable to find user.."},status: :not_found
    end
  end

  def markAsRead
    notification = Notification.find_by(id:params[:id])
    if notification
      if  notification.update(hasRead: true)
          render json: { message: "marked as read" },status: :ok
      else
         render json: {message:notification.errors.full_messages},status: :unprocessable_entity
      end
    else
      render json: {message: "no notification found" },status: :not_found
    end
  end

  private
   def is_registered_user
      unless current_user
          render json: {message: "only registered users can access notification"} ,status: :unauthorized
      end
   end
end
