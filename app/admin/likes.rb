ActiveAdmin.register Like do
   actions :index, :show, :destroy
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :likeable_type, :likeable_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:likeable_type, :likeable_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
