require 'rails_helper'

RSpec.describe Api::StorysController, type: :request do
   let(:user) { create(:user) }
   let(:user2) { create(:user) }
   let!(:story) { create(:story,user:user) }
   let(:user_token) {create(:doorkeeper_access_token,resource_owner_id:user.id)}
   let(:user_token2) {create(:doorkeeper_access_token,resource_owner_id:user2.id)}

   describe "get /storys#index" do

         context "when there is no access token" do
            before do
                get :"/api/storys",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end

        context "when the user is signed in" do
           before do
                get :"/api/storys",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
    end
    describe "post /storys#create" do
        context "when there is no access token" do
            before do
                post :"/api/create/story",params:{story:{note:"note"}}
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end
        context "when the user is signed in" do
            before do
                post :"/api/create/story",params:{access_token:user_token.token,story:{note:"note"}}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed in note less than 2" do
            before do
                post :"/api/create/story",params:{access_token:user_token.token,story:{note:"e"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in note greater than 20" do
             before do
                post :"/api/create/story",params:{access_token:user_token.token,story:{note:"ecsssssssssssssssssssssssssssssssssssssssssss"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in note equal to 20" do
             before do
                post :"/api/create/story",params:{access_token:user_token.token,story:{note:"12345678900987654321"}}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed in note equal to 2" do
             before do
                post :"/api/create/story",params:{access_token:user_token.token,story:{note:"es"}}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed in greater than 2 and less than  20" do
            before do
                post :"/api/create/story",params:{access_token:user_token.token,story:{note:"edca"}}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
    end
     describe "get /storys#delete" do

        context "when there is no access token" do
            before do
                delete :"/api/delete/story/#{story.id}"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end


        context "when the user is signed in but record not found" do
            before do
                delete :"/api/delete/story/#{"story"}",params:{access_token:user_token.token}
            end
            it "have http status 404" do
                expect(response).to have_http_status(404)
            end
        end

        context "when the user is signed in but not owner" do
           before do
                delete :"/api/delete/story/#{story.id}",params:{access_token:user_token2.token}
            end
            it "have http status 403" do
                expect(response).to have_http_status(403)
            end
        end
        context "when the user is signed in and owner" do
            before do
                delete :"/api/delete/story/#{story.id}",params:{access_token:user_token.token}
            end
            it "have http status 303" do
                expect(response).to have_http_status(303)
            end
        end
    end
end
