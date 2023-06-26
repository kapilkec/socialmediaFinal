require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  describe "get /posts#index" do

        context "when the user is not signed in" do
            before do
                get :index
            end
            it "renders index template" do
                expect(:response).to render_template(:index)
            end
        end
  end

end
