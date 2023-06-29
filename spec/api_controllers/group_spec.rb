require 'rails_helper'

RSpec.describe Api::GroupsController, type: :request do
   let(:user) { create(:user) }
   let(:user2) { create(:user) }
  let(:community) {create(:community)}
  let!(:group) {create(:group,user:user,community:community)}
  let(:user_token) {create(:doorkeeper_access_token,resource_owner_id:user.id)}
  let(:user_token2) {create(:doorkeeper_access_token,resource_owner_id:user2.id)}

  describe "get groups#show" do
    context "when there is no access token" do
        before do
            get :"/api/groups"
        end
        it "have http status 401" do
            expect(response).to have_http_status(401)
        end
      end
    context "when user signed in" do
        before do
            get :"/api/groups",params:{access_token:user_token.token}
        end
        it "have http status 200" do
            expect(response).to have_http_status(200)
        end
    end
  end
  describe "get groups#create" do
     context "when there is no access token" do
        before do
            post :"/api/groups/new/create",params:{group:{category:"1",name:"name",bio:"bio"}}
        end
        it "have http status 401" do
            expect(response).to have_http_status(401)
        end
      end
    context "when user signed in" do
        before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"1",name:"name",bio:"bio"}}
        end
        it "have http status 201" do
            expect(response).to have_http_status(201)
        end

    end

    context "when user signed in community not found" do
        before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"sd",name:"name",bio:"bio"}}
        end
        it "have http status 404" do
            expect(response).to have_http_status(404)
        end
    end
    context "when user signed in group name is less than 2" do
      before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"1",name:"n",bio:"bio"}}
        end
        it "have http status 422" do
            expect(response).to have_http_status(422)
        end
    end
    context "when user signed in group name is greater than 20" do
       before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"1",name:"nawwwwwwwwwwwwwwwwwwwwwwwwwwwwwwme",bio:"bio"}}
        end
        it "have http status 422" do
            expect(response).to have_http_status(422)
        end
    end
    context "when user signed in group bio is less than 2" do
       before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"1",name:"name",bio:"b"}}
        end
        it "have http status 422" do
            expect(response).to have_http_status(422)
        end
    end
    context "when user signed in group bio is greater than 20" do
       before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"1",name:"name",bio:"njnnnnnnnnnnnnnnnnnnnnnnnn"}}
        end
        it "have http status 422" do
            expect(response).to have_http_status(422)
        end
    end
    context "when user signed in group name is equal to 2" do
      before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"1",name:"ne",bio:"bio"}}
        end
        it "have http status 201" do
            expect(response).to have_http_status(201)
        end
    end
    context "when user signed in group name is equal to 20" do
        before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"1",name:"12345678901234567890",bio:"bio"}}
        end
        it "have http status 201" do
            expect(response).to have_http_status(201)
        end
    end
    context "when user signed in group bio is equal to 2" do
      before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"1",name:"12901234567890",bio:"bo"}}
        end
        it "have http status 201" do
            expect(response).to have_http_status(201)
        end
    end
    context "when user signed in group bio is equal to 20" do
      before do
            post :"/api/groups/new/create",params:{access_token:user_token.token, group:{category:"1",name:"adfa",bio:"12345678901234567890"}}
        end
      it "have http status 201" do
            expect(response).to have_http_status(201)
      end
    end
  end
  describe "get groups#delete" do
    context "when user not signed in" do
       before do
            delete :"/api/groups/deleteGroups/16"
        end
        it "have http status 401" do
            expect(response).to have_http_status(401)
        end
    end
    context "when user signed in" do
       before do
            delete :"/api/groups/deleteGroups/#{group.id}",params:{access_token:user_token.token}
        end
        it "have http status 303" do
            expect(response).to have_http_status(303)
        end
    end
    context "when user signed in but group not found" do
       before do
            delete :"/api/groups/deleteGroups/234",params:{access_token:user_token.token}
        end
        it "have http status 404" do
            expect(response).to have_http_status(404)
        end
    end
    context "when user signed in but not owner" do
       before do
            delete :"/api/groups/deleteGroups/#{group.id}",params:{access_token:user_token2.token}
        end
        it "have http status 403" do
            expect(response).to have_http_status(403)
        end
    end
  end
  #custom api
  describe "get groups#moregroups" do
    context "when user not signed in" do
       before do
            get :"/api/groups/mostgroups",params:{access_token:user_token2.token}
        end
        it "have http status 200" do
            expect(response).to have_http_status(200)
        end
    end
    context "when user signed in" do
       before do
            get :"/api/groups/mostgroups",params:{access_token:user_token.token}
        end
        it "have http status 200" do
            expect(response).to have_http_status(200)
        end
    end
  end
end
