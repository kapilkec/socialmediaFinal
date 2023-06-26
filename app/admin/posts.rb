ActiveAdmin.register Post do

  scope :likes_greater_than_one
  scope :with_zero_comments
  index do
    column :user_id
    column :title
    column :description
    column "postsPrivacy" ,:privacy
    column "Likes Count" do |post|
      post.likes.count
    end
     actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :user_id, :privacy
  #
  # or
  #
  permit_params do
    permitted = [:title, :description, :user_id, :privacy]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  filter :title
  filter :comments, as: :select, collection: proc { Comment.pluck(:comment  , :id) }


end
