class Api::FriendsController < Api::ApiController
  before_action :is_registered_user, only: [:following,:followers]

  def index
    users = User.all
    if users
       render json: users,status: :ok
    else
        render json: {message:"unable to fetch users"},status: :not_found
    end
  end

  def create
    record = Friend.new(friend_params)
    notification = Notification.new(user_id: params.require(:friend)[:toUser])
    record.notification = notification
    if record.save
      if notification.save
        render json: record,status: :created
      else
        render json: {message:notification.errors.full_messages},status: :unprocessable_entity
      end

    else
      render json: {message:record.errors.full_messages},status: :unprocessable_entity
    end


  end

  def destroy
    record = Friend.find_by( params[:id] )
    if record
      record.followed = false
      record.save
      render json: {message:"unfollowed"} ,status: :ok
    else
      render json: {message:"unable to find record"}, status: :not_found
    end
  end

  def following
    records = Friend.find_by(fromUser:current_user.id,followed: true)
    if records
      render json: records,status: :ok
    else
      render json: {message:"unable to find record"}, status: :not_found
    end
  end

  def followers
   records = Friend.find_by(toUser:current_user.id,followed: true)
    if records
      render json: records,status: :ok
    else
      render json: {message:"unable to fetch records" },status: :not_found
    end
  end

  private
  def friend_params
    params.require(:friend).permit(:fromUser, :toUser)
  end

  def friend_params2
    params.require(:friend).permit(:toUser)
  end
  def is_registered_user
      unless current_user
        render json: {messge: "only registered users can access comments"},status: :unauthorized
      end
    end

end
