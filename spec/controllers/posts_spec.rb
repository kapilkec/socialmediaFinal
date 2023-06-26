require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:post1){create(:post)}

  describe "get /posts#index" do

        context "when the user is not signed in" do
            before do
                get :index
            end
            it "renders index template" do
                expect(:response).to render_template(:index)
            end
        end

        context "when the user is signed in" do
            before do
                sign_in user
                get :index
            end
            it "renders index template" do
                expect(:response).to render_template(:index)
            end
        end
  end

   describe "get /posts#show" do

        context "when the user is not signed in" do
            it "redirects to login page" do
                get :show , params: {id: post1.id}
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when the user is signed in" do

            it "renders show template" do
                sign_in user
                get :show , params: {id: post1.id}
                expect(:response).to render_template(:show)
            end
        end
  end
    describe "get /posts#new" do

        context "when the user is not signed in" do
            it "redirects to login page" do
                get :new
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when the user is signed in" do

            it "renders new template" do
                sign_in user
                get :new
                expect(:response).to render_template(:new)
            end
        end
    end

    describe "post /posts#create" do

        context "when the user is not signed in" do
            it "redirects to login page" do
                post :create, params: {post:{title: "title",description:"description",privacy:"public"}}
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when the user is signed in but validations fails" do

            it "renders new template" do
                sign_in user
                post :create, params: {post:{title: "t",description:"description",privacy:"public"}}
                expect(:response).to render_template(:new)
            end
        end
        context "when the user is signed in and validtion succeedeed" do

            it "renders new template" do
                sign_in user
                post :create, params: {post:{title: "title",description:"description",privacy:"public"}}
                expect(:response).to redirect_to(posts_path)
            end
        end
    end

end
