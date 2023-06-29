require 'rails_helper'

RSpec.describe Api::FriendsController, type: :request do
    let(:user) { create(:user) }
    let(:user2) {create(:user)}
    let(:friend) { create(:friend) }
    let(:user_token) {create(:doorkeeper_access_token,resource_owner_id:user.id)}
    let(:user_token2) {create(:doorkeeper_access_token,resource_owner_id:user2.id)}

  describe "get /friends#index" do

        context "when there is no access token" do
            before do
                get :"/api/allusers"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in" do
            before do
                get :"/api/allusers",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
  end
  describe "post /friends#create" do
      context "when the user is not signed in" do
            before do
               post :"/api/friends/Following",params:{friend:{ fromUser:"431",toUser:"2"}}
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
      end

      context "when the user is signed in and send valid user" do
            before do
                post :"/api/friends/Following",params:{access_token:user_token.token, friend:{ fromUser:user.id,toUser:user2.id}}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
      end
    end

    describe "delete /friends#destroy" do

      context "when the user is not signed in" do
            before do
               delete :"/api/friends/unFollowing/#{friend.id}"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
      end
      context "when the user is signed in owner" do
            before do
               delete :"/api/friends/unFollowing/#{friend.id}",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
      end
    end
end
