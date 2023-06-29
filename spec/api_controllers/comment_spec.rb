require 'rails_helper'

RSpec.describe Api::CommentsController, type: :request do
  let(:user) { create(:user) }
  let(:post1){ create(:post,user:user) }
  let(:user3) {create(:user)}
  let(:user2) { create(:user) }
  let(:post2){ create(:post,user:user2) }
    let(:post3){ create(:post,user:user2) }
  let!(:comment) {create(:comment,post:post1,user:user2)}
  let!(:comment2) {create(:comment,post:post2,user:user)}

  let(:user_token) {create(:doorkeeper_access_token,resource_owner_id:user.id)}
  let(:user_token2) {create(:doorkeeper_access_token,resource_owner_id:user2.id)}
    let(:user_token3) {create(:doorkeeper_access_token,resource_owner_id:user3.id)}

  describe "get /comments#index" do

        context "when there is no access token" do
            before do
                get :"/api/posts/#{post1.id}/comments"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in but post not found" do
            before do
                get :"/api/posts/123/comments",params:{access_token:user_token.token}
            end
            it "should have http status 404" do
                expect(response).to have_http_status(404)
            end
        end
        context "when user signed in and comment not found" do
            before do
                get :"/api/posts/#{post3.id}/comments",params:{access_token:user_token.token}
            end
            it "should have http status 404" do
                expect(response).to have_http_status(404)
            end
        end
        context "when user signed in and comment not found" do
            before do
                get :"/api/posts/#{post3.id}/comments",params:{access_token:user_token.token}
            end
            it "should have http status 404" do
                expect(response).to have_http_status(404)
            end
        end
        context "when user signed in and comment found" do
            before do
                get :"/api/posts/#{post2.id}/comments",params:{access_token:user_token.token}
            end
            it "should have http status 302" do
                expect(response).to have_http_status(302)
            end
        end

    end
    describe "post /comments#create" do

        context "when there is no access token" do
            before do
                post :"/api/posts/#{post1.id}/comments"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in but post not found" do
            before do
                post :"/api/posts/123/comments",params:{access_token:user_token.token}
            end
            it "should have http status 404" do
                expect(response).to have_http_status(404)
            end
        end
        context "when the user is signed in but comment field less than 2" do

            before do
                post :"/api/posts/#{post1.id}/comments",params:{access_token:user_token.token,userId:user.id,comment:{commenter:"one",comment:"c"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in but comment field greater than 30" do

            before do
                post :"/api/posts/#{post1.id}/comments",params:{access_token:user_token.token,userId:user.id,comment:{comment:"ttttttttttttttttttttttttttttttttttt",commenter:"commenter"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in but comment field validation succedeed" do

            before do
                post :"/api/posts/#{post1.id}/comments",params:{access_token:user_token.token,userId:user.id,comment:{comment:"tttttt",commenter:"commenter"}}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed but comment is less than 30" do
            before do
               post :"/api/posts/#{post1.id}/comments",params:{access_token:user_token2.token,comment:{comment:"tflhhhhhhhhhhhhhhhdj",commenter:"commenter"}}
            end
            it "should have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed but comment is greater than 2" do
            before do
                post :"/api/posts/#{post1.id}/comments",params:{access_token:user_token2.token,comment:{comment:"tflhhhhhh",commenter:"commenter"}}
            end
            it "should have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed but comment is equal to 2" do
            before do
               post :"/api/posts/#{post1.id}/comments",params:{access_token:user_token2.token,comment:{comment:"tt",commenter:"commenter"}}
            end
            it "should have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed but comment is equal to 30" do
            before do
                post :"/api/posts/#{post1.id}/comments",params:{access_token:user_token2.token,comment:{comment:"123456789012345678901234567890",commenter:"commenter"}}
            end
            it "should have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed but comment is less than 30 and greater than 2" do
            before do
                post :"/api/posts/#{post1.id}/comments",params:{access_token:user_token2.token,comment:{comment:"123456784567890",commenter:"commenter"}}
            end
            it "should have http status 201" do
                expect(response).to have_http_status(201)
            end
        end

    end

    describe "post /comments#update" do

        context "when there is no access token" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in but post not found" do
            before do
                patch :"/api/posts/123/comments/#{comment.id}",params:{access_token:user_token2.token ,comment:{comment:"tttttt",commenter:"commenter"}}
            end
            it "should have http status 404" do
                expect(response).to have_http_status(404)
            end
        end

        context "when the user is signed in but post found" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token,comment:{comment:"tttttt",commenter:"commenter"}}
            end
            it "should have http status 200" do
                expect(response).to have_http_status(200)
            end
        end

        context "when the user is signed but not comment owner" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token.token,comment:{comment:"tttttt",commenter:"commenter"}}
            end
            it "should have http status 403" do
                expect(response).to have_http_status(403)
            end
        end
        context "when the user is signed comment owner" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token,comment:{comment:"tttttt",commenter:"commenter"}}
            end
            it "should have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when the user is signed but comment is less than 2" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token,comment:{comment:"t",commenter:"commenter"}}
            end
            it "should have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed but comment is greater than 30" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token,comment:{comment:"tflhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhdj",commenter:"commenter"}}
            end
            it "should have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed but comment is less than 30" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token,comment:{comment:"tflhhhhhhhhhhhhhhhdj",commenter:"commenter"}}
            end
            it "should have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when the user is signed but comment is greater than 2" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token,comment:{comment:"tflhhhhhh",commenter:"commenter"}}
            end
            it "should have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when the user is signed but comment is equal to 2" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token,comment:{comment:"tt",commenter:"commenter"}}
            end
            it "should have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when the user is signed but comment is equal to 30" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token,comment:{comment:"123456789012345678901234567890",commenter:"commenter"}}
            end
            it "should have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when the user is signed but comment is less than 30 and greater than 2" do
            before do
                patch :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token,comment:{comment:"123456784567890",commenter:"commenter"}}
            end
            it "should have http status 200" do
                expect(response).to have_http_status(200)
            end
        end

    end
    describe "post /comments#destroy" do

        context "when there is no access token" do
            before do
                delete :"/api/posts/#{post1.id}/comments/#{comment.id}"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in but post not found" do
            before do
                delete :"/api/posts/123/comments/#{comment.id}",params:{access_token:user_token2.token }
            end
            it "should have http status 404" do
                expect(response).to have_http_status(404)
            end
        end

        context "when the user is signed in but post found" do
            before do
                delete :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token2.token}
            end
            it "should have http status 303" do
                expect(response).to have_http_status(303)
            end
        end

        context "when the user is signed but not comment owner" do
            before do
                delete :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token3.token}
            end
            it "should have http status 401" do
                expect(response).to have_http_status(401)
            end
        end
        context "when the user is signed comment owner" do
            before do
                delete :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token.token}
            end
            it "should have http status 303" do
                expect(response).to have_http_status(303)
            end
        end
        context "when the user is signed in and also post owner" do
            before do
                delete :"/api/posts/#{post1.id}/comments/#{comment.id}",params:{access_token:user_token.token}
            end
            it "should have http status 303" do
                expect(response).to have_http_status(303)
            end
        end
    end

end
