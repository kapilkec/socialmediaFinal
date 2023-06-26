require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'association' do

    context "belongs_to"  do
      let(:user) {create(:user)}
      let(:like) {build(:like , user:user)}
      it "return like is true" do
        expect(like.user).to be_an_instance_of(User)
      end
    end
    context "belongs_to"  do
      let(:like) {create(:like,:for_post)}
      it "return like is true" do
        expect(like.likeable).to be_an_instance_of(Post)
      end
    end
    context "belongs_to"  do
      let(:like) {create(:like,:for_post)}
      it "return like is false" do
        expect(like.likeable).to_not be_an_instance_of(Comment)
      end
    end
    context "belongs_to"  do
      let(:like) {create(:like,:for_comment)}

      it "return like is true" do
        expect(like.likeable).to be_an_instance_of(Comment)
      end
    end
    context "belongs_to"  do
      let(:like) {create(:like,:for_comment)}

      it "return like is false" do
        expect(like.likeable).to_not be_an_instance_of(Post)
      end
    end

  end
end
