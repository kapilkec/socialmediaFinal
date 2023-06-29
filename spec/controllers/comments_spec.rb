require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:post1){ create(:post,user:user) }

  let(:user2) { create(:user) }
  let(:post2){ create(:post,user:user2) }
  let(:comment) {create(:comment,post:post2,user:user2)}
  let(:comment2) {create(:comment,post:post2,user:user)}


  describe "get /comments#edit" do

        context "when user is not signed in" do
            it "redirects to login page" do
                get :edit, params: {id:comment.id,post_id: post2.id}
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when user signed in and post not found" do
            it "redirects to root path" do
               sign_in user
               get :edit, params: {id:comment.id,post_id:"12"}
              expect(response).to redirect_to(root_path)
            end
        end
        context "when user signed in and comment not found" do
            it "redirects to root path" do
               sign_in user
               get :edit, params: {id:"22",post_id:post1.id}
              expect(response).to redirect_to(root_path)
            end
        end
        context "when the user is signed in and not the comment owner" do

            it "redirect to root path" do
                sign_in user
                get :edit, params: {id:comment.id,post_id: post2.id}
                expect(response).to redirect_to(root_path)
            end
        end
        context "when the user is signed in and user is the comment owner" do

            it "render edit template" do
                sign_in user
                get :edit, params: {id:comment2.id,post_id: post2.id}
                expect(response).to render_template(:edit)
            end
        end

        context "when the user is signed in and user is the post owner but not the comment owner" do

            it "redirect to root path" do
                sign_in user2
                get :edit, params: {id:comment2.id, post_id: post2.id}
                expect(response).to redirect_to(root_path)
            end
        end

    end

    describe "post /comments#create" do

        context "when user is not signed in" do
            it "redirects to login page" do
                post :create, params: {id:comment.id,post_id: post2.id,comment:{commenter:"one",comment:"comment"}}
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when user signed in and post not found" do
            it "redirects to root path" do
              sign_in user
              post :create, params: {id:comment.id,post_id:"2",comment:{commenter:"one",comment:"comment"}}
              expect(response).to redirect_to(root_path)
            end
        end
        context "when the user is signed in but validations fails" do

            it "should contain flash" do
                sign_in user
                post :create, params: {id:comment.id,post_id:post2.id,comment:{commenter:"one",comment:"c"}}
                expect(flash[:createError]).to eq("unable to create")
            end
        end
        context "when the user is signed in and validation succeedeed" do

            it "should flash a message" do
                sign_in user
                post :create, params: {id:comment.id,post_id:post2.id,comment:{commenter:"one",comment:"comment"}}
                expect(flash[:createSuccess]).to eq("created..")
            end
        end
    end
    describe "post /comments#update" do

        context "when user is not signed in" do
            it "redirects to login page" do
                patch :update, params: { id:comment.id, post_id: post2.id, comment:{commenter:"one", comment:"comment"} }
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when user signed in and post not found" do
            it "redirects to root path" do
              sign_in user
              patch :update, params: {id:comment.id,post_id:"2",comment:{commenter:"one",comment:"comment"}}
              expect(response).to redirect_to(root_path)
            end
        end

        context "when the user is signed but not comment owner" do

            it "redirect to root path" do
                sign_in user
                patch :update, params: {id:comment.id,post_id:post2.id,comment:{commenter:"one",comment:"c"}}
                expect(response).to redirect_to(root_path)
            end
        end
        context "when the user is signed in and validation succeedeed" do

            it "should flash a message" do
                sign_in user2
                patch :update, params: {id:comment.id,post_id:post2.id,comment:{commenter:"one",comment:"comment"}}
                expect(flash[:updateSuccess]).to eq("created..")
            end
        end
    end

    describe "post /comments#destroy" do

        context "when user is not signed in" do
            it "redirects to login page" do
                delete :destroy, params: { id:comment.id, post_id: post2.id }
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when user signed in and post not found" do
            it "redirects to root path" do
              sign_in user
              delete :destroy, params: { id:comment.id, post_id: post2.id }
              expect(response).to redirect_to(root_path)
            end
        end

        context "when the user is signed but not comment owner" do

            it "redirect to root path" do
                sign_in user
                delete :destroy, params: { id:comment.id, post_id: post2.id }
                expect(response).to redirect_to(root_path)
            end
        end
        context "when the user is signed in and also comment owner" do

            it "should flash a message" do
                sign_in user2
                delete :destroy, params: { id:comment.id, post_id: post2.id }
                expect(flash[:deleteSuccess]).to eq("deleted..")
            end
        end
        context "when the user is signed in and also post owner" do

            it "should flash a message" do
                sign_in user2
                delete :destroy, params: { id:comment.id, post_id: post2.id }
                expect(flash[:deleteSuccess]).to eq("deleted..")
            end
        end
    end
     describe "post /comments#destroy" do

        context "when user is not signed in" do
            it "redirects to login page" do
                delete :destroy, params: { id:comment.id, post_id: post2.id }
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when user signed in and post not found" do
            it "redirects to root path" do
              sign_in user
              delete :destroy, params: { id:comment.id, post_id: post2.id }
              expect(response).to redirect_to(root_path)
            end
        end

        context "when the user is signed but not comment owner" do

            it "redirect to root path" do
                sign_in user
                delete :destroy, params: { id:comment.id, post_id: post2.id }
                expect(response).to redirect_to(root_path)
            end
        end
        context "when the user is signed in and also comment owner" do

            it "should flash a message" do
                sign_in user2
                delete :destroy, params: { id:comment.id, post_id: post2.id }
                expect(flash[:deleteSuccess]).to eq("deleted..")
            end
        end
        context "when the user is signed in and also post owner" do

            it "should flash a message" do
                sign_in user2
                delete :destroy, params: { id:comment.id, post_id: post2.id }
                expect(flash[:deleteSuccess]).to eq("deleted..")
            end
        end
    end
end
