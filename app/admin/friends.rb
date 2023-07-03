ActiveAdmin.register Friend do
   actions :index, :show, :destroy
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :fromUser, :toUser
  #
  # or
  #
  # permit_params do
  #   permitted = [:fromUser, :toUser]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
