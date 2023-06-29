require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { create(:user) }
   let(:user2) { create(:user) }
  let(:community) {create(:community)}
  let!(:group) {create(:group,user:user,community:community)}

  describe "get groups#show" do
    context "when user not signed in" do
      before do
        get :show
      end
      it "renders show_template" do
        expect(response).to render_template(:show)
      end
    end
    context "when user signed in" do
      before do
        sign_in user
        get :show
      end
      it "renders show_template" do
        expect(response).to render_template(:show)
      end
    end
  end
  describe "get groups#new" do
    context "when user not signed in" do
      before do
        get :new
      end
      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "when user signed in" do
      before do
        sign_in user
        get :new
      end
      it "renders new_template" do
        expect(response).to render_template(:new)
      end
    end
  end
  describe "get groups#mygroups" do
    context "when user not signed in" do
      before do
        get :mygroups
      end
      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "when user signed in" do
      before do
        sign_in user
        get :mygroups
      end
      it "renders new_template" do
        expect(response).to render_template(:mygroups)
      end
    end
  end
  describe "get groups#view" do
    context "when user not signed in" do
      before do
        get :view,params:{id:group.id}
      end
      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "when user signed in" do
      before do
        sign_in user
        get :view,params:{id:group.id}
      end
      it "renders new_template" do
        expect(response).to render_template(:view)
      end
    end
    context "when user signed in no group found" do
      before do
        sign_in user
        get :view,params:{id:"group"}
      end
      it "redirect to root path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end
  describe "get groups#join" do
    context "when user not signed in" do
      before do
        get :join, params:{id:group.id}
      end
      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "when user signed in" do
      before do
        sign_in user
        get :join,params:{group_id:group.id}
      end
      it "renders join_template" do
        expect(response).to render_template(:join)
      end
    end
    context "when user signed in and group around" do
      before do
        sign_in user
        get :join,params:{group_id:"group"}
      end
      it "redirect to root path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "get groups#join" do
    context "when user not signed in" do
      before do
        get :join, params:{id:group.id}
      end
      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "when user signed in" do
      before do
        sign_in user
        get :join,params:{group_id:group.id}
      end
      it "renders join_template" do
        expect(response).to render_template(:join)
      end
    end
    context "when user signed in and group not found" do
      before do
        sign_in user
        get :join,params:{group_id:"group"}
      end
      it "redirect to root path" do
        expect(response).to redirect_to(root_path)
      end
    end

  end

   describe "get groups#create" do
    context "when user not signed in" do
      before do
        post :create, params:{group:{category:"cricket",name:"name",bio:"bio"}}
      end
      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "when user signed in" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"name",bio:"bio"}}
      end
      it "redirect to groups_path" do
        expect(response).to redirect_to(groups_path)
      end
    end
    context "when user signed in but community not found" do
      before do
        sign_in user
        post :create, params:{group:{category:"sd1",name:"name",bio:"bio"}}
      end
      it "redirect to root_path" do
        expect(response).to redirect_to(root_path)
      end
    end
    context "when user signed in but community found" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"name",bio:"bio"}}
      end
      it "redirect to root_path" do
        expect(response).to redirect_to(groups_path)
      end
    end
    context "when user signed in group name is less than 2" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"n",bio:"bio"}}
      end
      it "render template :new" do
        expect(response).to render_template(:new)
      end
    end
    context "when user signed in group name is greater than 20" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"njnnnnnnnnnnnnnnnnnnnnnnnn",bio:"bio"}}
      end
      it "render template :new" do
        expect(response).to render_template(:new)
      end
    end
    context "when user signed in group bio is less than 2" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"ddn",bio:"o"}}
      end
      it "render template :new" do
        expect(response).to render_template(:new)
      end
    end
    context "when user signed in group bio is greater than 20" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"www",bio:"njnnnnnnnnnnnnnnnnnnnnnnnn"}}
      end
      it "render template :new" do
        expect(response).to render_template(:new)
      end
    end
    context "when user signed in group name is equal to 2" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"ww",bio:"njnnnnnnnn"}}
      end
      it "render template :new" do
        expect(response).to redirect_to(groups_path)
      end
    end
    context "when user signed in group name is equal to 20" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"12345678901234567890",bio:"njnnnnnnnnnnn"}}
      end
      it "render template :new" do
        expect(response).to redirect_to(groups_path)
      end
    end
    context "when user signed in group bio is equal to 2" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"wfw",bio:"aa"}}
      end
      it "render template :new" do
        expect(response).to redirect_to(groups_path)
      end
    end
    context "when user signed in group bio is equal to 20" do
      before do
        sign_in user
        post :create, params:{group:{category:"1",name:"wfwqf",bio:"12345678901234567890"}}
      end
      it "render template :new" do
        expect(response).to redirect_to(groups_path)
      end
    end

  end
  describe "get groups#delete" do
    context "when user not signed in" do
      before do
        delete :delete,params:{group_id:group.id}
      end
      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "when user signed in" do
      before do
        sign_in user
        delete :delete,params:{group_id:group.id}
      end
      it "redirect to groups_mygroups_path" do
        expect(response).to redirect_to(groups_mygroups_path)
      end
    end
    context "when user signed in but group not found" do
      before do
        sign_in user
        delete :delete,params:{group_id:"group"}
      end
      it "redirect to root_path" do
        expect(response).to redirect_to(root_path)
      end
    end
    context "when user signed in but not owner" do
      before do
        sign_in user2
        delete :delete,params:{group_id:group.id}
      end
      it "redirect to root_path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
