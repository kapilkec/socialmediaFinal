require 'rails_helper'

RSpec.describe Api::PostsController, type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:post1){ create(:post,user:user) }
  let!(:like) {create(:like,likeable:post1,user:user)}
  let!(:like2) {create(:like,likeable:post1,user:user2)}
  let(:user2) { create(:user) }
  let(:post2){ create(:post,user:user2) }
  let!(:comment) {create(:comment,post:post1,user:user2)}
  let!(:comment2) {create(:comment,post:post2,user:user)}

   let(:user_token) {create(:doorkeeper_access_token,resource_owner_id:user.id)}
   let(:user_token2) {create(:doorkeeper_access_token,resource_owner_id:user2.id)}


    describe "get /posts#index" do

        context "when there is no access token" do
            before do
                get :"/api/posts"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in" do
            before do
                get :"/api/posts" ,params:{access_token:user_token.token}
            end
            it "should have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
    end

    describe "get /posts#show" do

        context "when there is no access token" do
            before do
                get :"/api/posts/#{post1.id}"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in but post not found" do
            before do
                get :"/api/posts/postid",params:{access_token:user_token.token}
            end
            it "should have http status 404" do
                expect(response).to have_http_status(404)
            end
        end
        context "when the user is signed in post found" do
            before do
                get :"/api/posts/#{post1.id}",params:{access_token:user_token.token}
            end
            it "should have http status 302 " do
                expect(response).to have_http_status(302)
            end
        end
    end



    describe "post /posts#create" do

         context "when there is no access token" do
            before do
                post :"/api/posts",params:{userId:user.id,post:{title:"title",description:"description",privacy:"public"}}
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end


        context "when the user is signed in but title field less than 2" do

            before do
                post :"/api/posts",params:{access_token:user_token.token,userId:user.id,post:{title:"t",description:"description",privacy:"public"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in but title field greater than 20" do

            before do
                post :"/api/posts",params:{access_token:user_token.token,userId:user.id,post:{title:"ttttttttttttttttttttttttttttttttttt",description:"description",privacy:"public"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in but description field less than 10" do
            before do
                post :"/api/posts",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"des",privacy:"public"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in but description field greater than 50" do
            before do
                post :"/api/posts",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"desssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",privacy:"public"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in title field validation is succeeded" do
            before do
                post :"/api/posts",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"}}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed in description field validation is succeeded" do
            before do
                post :"/api/posts",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"}}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
        context "when the user is signed in validation is succeeded" do
            before do
                post :"/api/posts",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"}}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
    end

    describe "post /posts#edit" do

        context "when there is no access token" do
            before do
                get :"/api/posts/#{post1.id}/edit"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in and not the post owner" do
            before do
               get :"/api/posts/#{post1.id}/edit",params:{access_token:user_token2.token}
            end
            it "have http status 403" do
                expect(response).to have_http_status(403)
            end
        end
        context "when the user is signed in and user is the post owner" do
            before do

               get :"/api/posts/#{post1.id}/edit",params:{access_token:user_token.token }
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "post /posts#update" do

        context "when there is no access token" do
            before do
                patch :"/api/posts/#{post1.id}"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in and not the post owner" do
            before do
               patch :"/api/posts/#{post1.id}",params:{access_token:user_token2.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"}}
            end
            it "have http status 403" do
                expect(response).to have_http_status(403)
            end
        end
        context "when the user is signed in and user is the post owner" do
            before do

               patch :"/api/posts/#{post1.id}",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"} }
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
         context "when the user is signed in but post not found" do
            before do
               patch :"/api/posts/234",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"} }
            end
            it "should have http status 404" do
                expect(response).to have_http_status(404)
            end
        end
        context "when the user is signed in post found" do
            before do
               patch :"/api/posts/#{post1.id}",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"} }
            end
            it "should have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
                context "when the user is signed in but title field less than 2" do

            before do
                patch :"/api/posts/#{post1.id}",params:{access_token:user_token.token,userId:user.id,post:{title:"t",description:"description",privacy:"public"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in but title field greater than 20" do

            before do
                patch :"/api/posts/#{post1.id}",params:{access_token:user_token.token,userId:user.id,post:{title:"ttttttttttttttttttttttttttttttttttt",description:"description",privacy:"public"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in but description field less than 10" do
            before do
                patch :"/api/posts/#{post1.id}",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"des",privacy:"public"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in but description field greater than 50" do
            before do
                patch :"/api/posts/#{post1.id}",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"desssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",privacy:"public"}}
            end
            it "have http status 422" do
                expect(response).to have_http_status(422)
            end
        end
        context "when the user is signed in title field validation is succeeded" do
            before do
                patch :"/api/posts/#{post1.id}",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"}}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when the user is signed in description field validation is succeeded" do
            before do
                patch :"/api/posts/#{post1.id}",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"}}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when the user is signed in validation is succeeded" do
            before do
                patch :"/api/posts/#{post1.id}",params:{access_token:user_token.token,userId:user.id,post:{title:"tttt",description:"dessssssss",privacy:"public"}}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "post /posts#destroy" do

        context "when there is no access token" do
            before do
                delete :"/api/posts/#{post1.id}"
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when the user is signed in and not the post owner" do
            before do
               delete :"/api/posts/#{post1.id}",params:{access_token:user_token2.token}
            end
            it "have http status 403" do
                expect(response).to have_http_status(403)
            end
        end


        context "when the user is signed in post found" do
            before do
               delete :"/api/posts/#{post1.id}",params:{access_token:user_token.token}
            end
            it "have http status 303" do
                expect(response).to have_http_status(303)
            end
        end
    end

    #custom api
    describe "get posts#postwithzerolikes" do
        context "when user not signed in" do
            before do
                get :"/api/posts/zerolikes",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when user signed in" do
            before do
                get :"/api/posts/zerolikes",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end

    end
     describe "get posts#postwithMorelikes" do
        context "when user not signed in" do
            before do
                get :"/api/posts/mostlikes",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when user signed in" do
            before do
                get :"/api/posts/mostlikes",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end

    end
    describe "get posts#postwithMoreComments" do
        context "when user not signed in" do
            before do
                get :"/api/posts/mostComments",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end
        context "when user signed in" do
            before do
                get :"/api/posts/mostComments",params:{access_token:user_token.token}
            end
            it "have http status 200" do
                expect(response).to have_http_status(200)
            end
        end

    end
end

