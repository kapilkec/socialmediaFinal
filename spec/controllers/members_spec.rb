require 'rails_helper'

RSpec.describe MembersController, type: :controller do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:group) {create(:group,user:user) }

    describe "post /members#create" do

        context "when the user is not signed in" do
            it "redirects to login page" do
                post :create , params:{member:{group_id:group.id,rating:2}}
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when the user is signed in and user is group owner" do
            before do
                sign_in user
                post :create , params:{member:{group_id:group.id,rating:2}}
            end
            it "redirect to root path" do
                expect(response).to redirect_to(root_path)
            end
        end
        context "when the user is signed in and user is not group owner" do
            before do
                sign_in user2
                post :create , params:{member:{group_id:group.id,rating:2}}
            end
            it "fredirect to groups_path" do
                expect(response).to redirect_to(groups_path)
            end
        end
        context "when the user is signed in and user is no group found" do
            before do
                sign_in user2
                post :create , params:{member:{group_id:"12",rating:2}}
            end
            it "fredirect to groups_path" do
                expect(flash[:alert]).to eq("no group found")
            end
        end
    end
end
