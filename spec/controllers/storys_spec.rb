require 'rails_helper'

RSpec.describe StorysController, type: :controller do
  let(:user) { create(:user) }
    let(:user2) { create(:user) }
  let!(:story) { create(:story,user:user) }
    describe "get /storys#index" do

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

    describe "get /storys#new" do
        context "when the user is not signed in" do
            before do
                get :new
            end
            it "redirect to user session path" do
                expect(response).to redirect_to(new_user_session_path)
            end
        end
        context "when the user is signed in" do
            before do
                sign_in user
                get :new
            end
            it "render index template" do
                expect(response).to render_template(:new)
            end
        end
    end

    describe "get /storys#create" do
        context "when the user is not signed in" do
            before do
                post :create
            end
            it "redirect to user session path" do
                expect(response).to redirect_to(new_user_session_path)
            end
        end
        context "when the user is signed in" do
            before do
                sign_in user
                post :create, params:{story:{note:"note"}}
            end
            it "redirect to user storys path" do
                expect(response).to redirect_to(storys_path)
            end
        end
        context "when the user is signed in note less than 2" do
            before do
                sign_in user
                post :create, params:{story:{note:"n"}}
            end
            it "render index template" do
                expect(response).to render_template(:new)
            end
        end
        context "when the user is signed in note greater than 20" do
            before do
                sign_in user
                post :create, params:{story:{note:"nbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"}}
            end
            it "render index template" do
                expect(response).to render_template(:new)
            end
        end
        context "when the user is signed in note equal to 20" do
            before do
                sign_in user
                post :create, params:{story:{note:"12345678900987654321"}}
            end
           it "redirect to user storys path" do
                expect(response).to redirect_to(storys_path)
            end
        end
        context "when the user is signed in note equal to 2" do
            before do
                sign_in user
                post :create, params:{story:{note:"nb"}}
            end
           it "redirect to user storys path" do
                expect(response).to redirect_to(storys_path)
            end
        end
        context "when the user is signed in greater than 2 and less than  20" do
            before do
                sign_in user
                post :create, params:{story:{note:"nbd"}}
            end
           it "redirect to user storys path" do
                expect(response).to redirect_to(storys_path)
            end
        end
    end
    describe "get /storys#delete" do

        context "when the user is signed in" do
            before do
                sign_in user
                delete :delete, params:{format:story.id}
            end
           it "redirect to user storys path" do
                expect(response).to redirect_to(storys_path)
            end
        end


        context "when the user is signed in but record not found" do
            before do
                sign_in user
                delete :delete, params:{format:"story"}
            end
           it "flash a message" do
                expect(flash[:alert]).to eq("no record found")
            end
        end

        context "when the user is signed in but not owner" do
            before do
                sign_in user2
                delete :delete, params:{format:story.id}
            end
           it "flash a message" do
                expect(flash[:notice]).to eq("Unauthorized access")
            end
        end
        context "when the user is signed in and owner" do
            before do
                sign_in user
                delete :delete, params:{format:story.id}
            end
           it "redirect to user storys path" do
                expect(response).to redirect_to(storys_path)
            end
        end
    end
end
