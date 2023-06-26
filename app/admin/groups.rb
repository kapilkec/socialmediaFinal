ActiveAdmin.register Group do

  scope :group_with_community_one
  index do
    column :name
    column :bio
    column "Members Count" do |group|
      group.members.count
    end
    column :community_id
     actions
  end
  permit_params do
    permitted = [:name, :bio, :user_id, :community_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  filter :name

end
