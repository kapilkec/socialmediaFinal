require 'rails_helper'

RSpec.describe Story, type: :model do
  describe 'association' do

    context "belongs_to"  do
      let(:user) {create(:user)}
      let(:story) {build(:story , user:user)}
      it "return story is true" do
        expect(story.user).to be_an_instance_of(User)
      end
    end

  end

  describe "validation on note field" do
    context "when note is nil" do
      let(:story) {build(:story,note:nil)}
      before do
        story.save
      end
      it "should return false" do
        expect(story.errors).to include(:note)
      end
    end

    context "when note is present" do
      let(:story) { build(:story,note:"one") }
      before do
        story.save
      end
      it "should return true" do
        expect(story.errors).to_not include(:note)
      end
    end

    context "when note length is less than 2 " do
      let(:story) { build(:story,note:"e") }
      before do
        story.save
      end
      it "should return false" do
        expect(story.errors).to include(:note)
      end
    end
    context "when note length is greater than 20 " do
      let(:story) { build(:story,note:"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee") }
      before do
        story.save
      end
      it "should return false" do
        expect(story.errors).to include(:note)
      end
    end
    context "when note length is greater than 2 and less than 20" do
      let(:story) { build(:story,note:"dffssss") }
      before do
        story.save
      end
      it "should return true" do
        expect(story.errors).to_not include(:note)
      end
    end

  end
end
