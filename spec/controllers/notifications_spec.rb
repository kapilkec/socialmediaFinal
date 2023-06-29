require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:notification) {create(:notification,user:user)}
  describe "get /notifications#view" do
        context "when the user is not signed in" do
            it "redirects to login page" do
                get :view
                expect(response).to redirect_to(new_user_session_path)
            end
        end
        context "when the user is signed in" do
            it "renders view template" do
                sign_in user
                get :view
                expect(response).to render_template(:view)
            end
        end
  end
  describe "get /notifications#markAsRead" do
        context "when the user is not signed in" do
            it "redirects to login page" do
                post :markAsRead, params:{id:notification.id}
                expect(response).to redirect_to(new_user_session_path)
            end
        end
        context "when the user is signed in and notification not found" do
            it "flash a message" do
                sign_in user
                post :markAsRead, params:{id:"notification"}
                expect(flash[:notice]).to eq("no notification found")
            end
        end
        context "when the user is signed in and notification found" do
            it "redirect to notifications_all_path" do
                sign_in user
                post :markAsRead, params:{id:notification.id}
                expect(response).to redirect_to(notifications_all_path)
            end
        end
  end
end
