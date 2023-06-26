ActiveAdmin.register Comment ,as: "PostComment" do
  scope :likes_greater_than_one
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :commenter, :comment, :post_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:commenter, :comment, :post_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
