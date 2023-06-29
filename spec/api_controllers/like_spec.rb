require 'rails_helper'

RSpec.describe Api::LikesController, type: :request do
  let(:user1) { create(:user) }
  let(:post1){ create(:post,user:user1) }

  let(:user2) { create(:user) }
  let(:post2){ create(:post,user:user2) }
  let(:like) {create(:like,likeable:post1,user:user1)}

  let(:comment1) {create(:comment,user:user1,post:post1)}
  let(:like2) {create(:like,likeable:comment1,user:user1)}

  let(:user_token) {create(:doorkeeper_access_token,resource_owner_id:user1.id)}
  let(:user_token2) {create(:doorkeeper_access_token,resource_owner_id:user2.id)}

  describe "create /likes#createLikeForPost" do

        context "when the user is not signed in" do
            before do
                post :"/api/posts/like/create",params:{post_id:post1.id}
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when user signed in and post not found" do
            before do
                post :"/api/posts/like/create",params:{access_token:user_token.token,post_id:"post1"}
            end
            it "have http status 404" do
                expect(response).to have_http_status(404)
            end
        end

        context "when user signed in and user liked" do
            before do
                post :"/api/posts/like/create",params:{access_token:user_token.token,post_id:post1.id}
            end
            it "have http status 201" do
                expect(response).to have_http_status(201)
            end
        end
  end

  describe "create /likes#destroyLikeForPost" do

        context "when the user is not signed in" do
            before do
                delete :"/api/posts/like/delete",params:{post_id:post1.id,like_id:like.id}
            end
            it "have http status 401" do
                expect(response).to have_http_status(401)
            end
        end

        context "when user signed in and post not found" do
            before do
                delete :"/api/posts/like/delete",params:{access_token:user_token.token,post_id:"post1",like_id:like.id}
            end
            it "have http status 404" do
                expect(response).to have_http_status(404)
            end
        end

        context "when user signed in and like not found" do
            before do
                delete :"/api/posts/like/delete",params:{access_token:user_token.token,post_id:post1.id,like_id:"like"}
            end
            it "have http status 404" do
                expect(response).to have_http_status(404)
            end
        end
        context "when user signed in and like found" do
            before do
                delete :"/api/posts/like/delete",params:{access_token:user_token.token,post_id:post1.id,like_id:like.id}
            end
            it "have http status 303" do
                expect(response).to have_http_status(303)
            end
        end
  end
end
