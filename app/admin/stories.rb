ActiveAdmin.register Story do
  scope :not_expired
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :note, :user_id, :expiration_time
  #
  # or
  #
  # permit_params do
  #   permitted = [:note, :user_id, :expiration_time]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
