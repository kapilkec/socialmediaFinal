require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user1) { create(:user) }
  let(:post1){ create(:post,user:user1) }

  let(:user2) { create(:user) }
  let(:post2){ create(:post,user:user2) }
  let(:like) {create(:like,likeable:post1,user:user1)}

  let(:comment1) {create(:comment,user:user1,post:post1)}
  let(:like2) {create(:like,likeable:comment1,user:user1)}


  describe "create /likes#createLikeForPost" do

        context "when the user is not signed in" do
            before do
                post :createLikeForPost,params:{post_id:post1}
            end
            it "redirect to root path" do
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when user signed in and post not found" do
            it "redirects to root path" do
              sign_in user1
              post :createLikeForPost,params:{post_id:"post1"}
              expect(response).to redirect_to(root_path)
            end
        end

        context "when user signed in and user liked" do
            it "flash a message" do
              sign_in user1
              post :createLikeForPost,params:{post_id:post1.id}
              expect(flash[:alert]).to eq("like saved")
            end
        end
  end
  describe "create /likes#destroyPostLike" do

        context "when the user is not signed in" do
            before do
                delete :destroyPostLike,params:{post_id:post1,like_id:like.id}
            end
            it "redirect to root path" do
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when user signed in and post not found" do
            it "redirects to root path" do
              sign_in user1
              delete :destroyPostLike,params:{post_id:"post1",like_id:like.id}
              expect(response).to redirect_to(root_path)
            end
        end

        context "when user signed in and like record not found" do
            it "flash a message" do
              sign_in user1
              delete :destroyPostLike,params:{post_id:post1,like_id:"like"}
              expect(flash[:alert]).to eq("no like record found")
            end
        end

        context "when user signed in and like record found" do
            it "flash a message" do
              sign_in user1
              delete :destroyPostLike,params:{post_id:post1,like_id:like.id}
              expect(flash[:alert]).to eq("like deleted")
            end
        end
  end
  describe "create /likes#createLikeForComment" do

        context "when the user is not signed in" do
            before do
                post :createLikeForComment,params:{comment_id:comment1.id,post_id:post1}
            end
            it "redirect to root path" do
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when user signed in and post not found" do
            it "redirects to root path" do
              sign_in user1
              post :createLikeForComment,params:{comment_id:"comment1",post_id:post1}
              expect(response).to redirect_to(root_path)
            end
        end

        context "when user signed in and user liked" do
            it "flash a message" do
              sign_in user1
              post :createLikeForComment,params:{comment_id:comment1.id,post_id:post1}
              expect(flash[:alert]).to eq("like saved")
            end
        end
  end
  describe "create /likes#destroyCommenttLike" do

        context "when the user is not signed in" do
            before do
                post :deleteCommentLike,params:{comment_id:comment1.id,like_id:like2.id}
            end
            it "redirect to root path" do
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when user signed in and comment not found" do
            it "redirects to root path" do
              sign_in user1
              post :deleteCommentLike,params:{comment_id:"comment1",like_id:like2.id}
              expect(response).to redirect_to(root_path)
            end
        end

        context "when user signed in and like record not found" do
            it "flash a message" do
              sign_in user1
              post :deleteCommentLike,params:{comment_id:comment1.id,like_id:"like"}
              expect(flash[:alert]).to eq("no like record found")
            end
        end

        context "when user signed in and like record found" do
            it "flash a message" do
              sign_in user1
              post :deleteCommentLike,params:{comment_id:comment1.id,like_id:like2.id}
              expect(flash[:alert]).to eq("like deleted")
            end
        end
  end

end
