require 'rails_helper'

RSpec.describe Api::NotificationsController, type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:notification) {create(:notification,user:user)}
    let(:user_token) {create(:doorkeeper_access_token,resource_owner_id:user.id)}
      let(:user_token2) {create(:doorkeeper_access_token,resource_owner_id:user2.id)}


  describe "get /notifications#view" do
        context "when there is no access token" do
            before do
                get :"/api/notifications/all"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end
        context "when the user is signed in" do
            before do
                get :"/api/notifications/all",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
  end

  describe "get /notifications#markAsRead" do
       context "when there is no access token" do
            before do
                post :"/api/notifications/markasread",params:{id:notification.id}
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end
        context "when the user is signed in and not notification owner" do
            before do
                post :"/api/notifications/markasread",params:{id:notification.id, access_token:user_token2.token}
            end
            it "have http status 403" do
                expect(response).to have_http_status(403)
            end
        end
        context "when the user is signed in and notification not found" do
             before do
                post :"/api/notifications/markasread",params:{id:"notification", access_token:user_token2.token}
            end
            it "have http status 404" do
                expect(response).to have_http_status(404)
            end
        end
        context "when the user is signed in and notification  found" do
             before do
                post :"/api/notifications/markasread",params:{id:notification.id, access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
  end
end
