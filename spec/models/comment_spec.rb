require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "validation on comment field" do
    context "when comment is nil" do
      let(:comment) {build(:comment,comment:nil)}
      before do
         comment.save
      end
      it "should return false" do
        expect(comment.errors).to include(:comment)
      end
    end

    context "when comment is present" do
      let(:comment) {build(:comment,comment:"comment")}
      before do
         comment.save
      end
      it "should return true" do
        expect(comment.errors).to_not include(:comment)
      end
    end

    context "when comment is less than 2" do
      let(:comment) {build(:comment,comment:"c")}
      before do
         comment.save
      end
      it "should return false" do
        expect(comment.errors).to include(:comment)
      end
    end

    context "when comment is greater than 30" do
      let(:comment) {build(:comment,comment:"commentttttttttttttttttttttttttttttttttttttttttttttttttttttttttt")}
      before do
         comment.save
      end
      it "should return false" do
        expect(comment.errors).to include(:comment)
      end
    end

    context "when comment is greater than 2" do
      let(:comment) {build(:comment,comment:"com")}
      before do
         comment.save
      end
      it "should return true" do
        expect(comment.errors).to_not include(:comment)
      end
    end

    context "when comment is less than 30" do
      let(:comment) {build(:comment,comment:"commmmmmmmmmm")}
      before do
         comment.save
      end
      it "should return true" do
        expect(comment.errors).to_not include(:comment)
      end
    end

    context "when comment is greater than 2 and less than 30" do
      let(:comment) {build(:comment,comment:"commment comment")}
      before do
         comment.save
      end
      it "should return true" do
        expect(comment.errors).to_not include(:comment)
      end
    end

    context "when comment is equal to 2" do
      let(:comment) {build(:comment,comment:"co")}
      before do
         comment.save
      end
      it "should return true" do
        expect(comment.errors).to_not include(:comment)
      end
    end

    context "when comment is equal to 30" do
      let(:comment) {build(:comment,comment:"123456789012345678901234567890")}
      before do
         comment.save
      end
      it "should return true" do
        expect(comment.errors).to_not include(:comment)
      end
    end
  end

  describe 'association' do

    context "belongs_to"  do
      let(:user) {create(:user)}
      let(:comment) {build(:comment , user:user)}
      it "return post is true" do
        expect(comment.user).to be_an_instance_of(User)
      end
    end

    context "belongs_to"  do
      let(:post) {create(:post)}
      let(:comment) {build(:comment , post:post)}
      it "return post is true" do
        expect(comment.post).to be_an_instance_of(Post)
      end
    end
    context "has_many" do

      [:likes].each do |each|
        it each.to_s.humanize do
          association = Comment.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end

  
  end
end
