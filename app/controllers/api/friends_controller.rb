class Api::FriendsController < Api::ApiController
  # before_action :authenticate_user!, only: [:following,:followers]

  def index
    users = User.all
    render json: users,status: :ok
  end

  def create
    record = Friend.new(friend_params)
    notification = Notification.new(user_id: params.require(:friend)[:toUser])
    record.notification = notification
    if record.save and notification.save
        render json: record,status: :ok
    else
      render json: {message:"unable to create record" },status: :ok
    end


  end

  def destroy
    record = Friend.find_by( params[:id] )

    if record
      record.followed = false
      record.save
      render json: {message:"unfollowed"} ,status: :ok
    else
      render json: {message:"unable to unfollow"}, status: :ok
    end
  end

  def following
    records = Friend.find_by(fromUser:1,followed: true)
    if records
      render json: records,status: :ok
    else
      render json: {message:"unable to fetch records" },status: :ok
    end
  end

  def followers
   records = Friend.find_by(toUser:1,followed: true)
    if records
      render json: records,status: :ok
    else
      render json: {message:"unable to fetch records" },status: :ok
    end
  end

  def friend_params
    params.require(:friend).permit(:fromUser, :toUser)
  end

  def friend_params2
    params.require(:friend).permit(:toUser)
  end

end
