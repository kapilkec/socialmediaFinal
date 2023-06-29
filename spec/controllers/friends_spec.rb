require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
    let(:user) { create(:user) }
    let(:user2) {create(:user)}
    let(:friend) { create(:friend) }

    describe "get /friends#index" do

        context "when the user is not signed in" do
            before do
                get :index
            end
            it "renders index template" do
                expect(response).to render_template(:index)
            end
        end

        context "when the user is signed in" do
            before do
                sign_in user
                get :index
            end
            it "renders index template" do
                expect(response).to render_template(:index)
            end
        end
    end

    describe "post /friends#create" do
      context "when the user is not signed in" do
            before do
                post :create,params:{friend:{toUser:"1",fromUser:"1"}}
            end
            it "redirect to sign in" do
                expect(response).to redirect_to(new_user_session_path)
            end
      end
      context "when the user is signed in but not recordOwner" do
            before do
              sign_in user
                post :create,params:{friend:{ fromUser:"431",toUser:"2"}}
            end
            it "redirect to root path" do
                expect(response).to redirect_to(root_path)
            end
      end
      context "when the user is signed in and send valid user" do
            before do
                sign_in user
                post :create,params:{friend:{ fromUser:user.id,toUser:user2.id}}
            end
            it "flash a message" do
                expect(flash[:alert]).to eq("created")
            end
      end
    end
    describe "delete /friends#destroy" do

      context "when the user is signed in but record not found" do
            before do
              sign_in user
              delete :destroy,params:{format:"sf"}
            end
            it "flash a message" do
                expect(flash[:alert]).to eq("no record found")
            end
      end
      context "when the user is signed in owner" do
            before do
                sign_in user
                delete :destroy,params:{format:friend.id}
            end
            it "redirect to allusers_path" do
                expect(response).to redirect_to(allusers_path)
            end
      end
      context "when the user is signed in but not owner" do
            before do
                sign_in user2
                delete :destroy,params:{format:friend.id}
            end
            it "redirect to allusers_path" do
                expect(response).to redirect_to(allusers_path)
            end
      end
    end

end
