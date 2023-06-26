require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe "validation on fromUser field" do
    context "when fromUSer is nil" do
      let(:friend) {build(:friend,fromUser:nil)}
      before do
        friend.save
      end
      it "should return false" do
        expect(friend.errors).to include(:fromUser)
      end
    end
    context "when fromUSer is present" do
      let(:friend) {build(:friend,fromUser:"1")}
      before do
        friend.save
      end
      it "should return false" do
        expect(friend.errors).to_not include(:fromUser)
      end
    end
  end

  describe "validation on toUser field" do
    context "when toUser is nil" do
      let(:friend) {build(:friend,toUser:nil)}
      before do
        friend.save
      end
      it "should return false" do
        expect(friend.errors).to include(:toUser)
      end
    end
    context "when toUser is present" do
      let(:friend) {build(:friend,toUser:"1")}
      before do
        friend.save
      end
      it "should return false" do
        expect(friend.errors).to_not include(:toUser)
      end
    end
  end
  describe "validation on followed attribute" do
    context "when a new friend is created" do
      let(:friend) { Friend.new }

      it "has followed set to true by default" do
        expect(friend.followed).to be true
      end
    end
    context "when a new friend is created" do
      let(:friend) { Friend.new }

      it "has followed set to true by default" do
        expect(friend.followed).to_not be false
      end
    end
  end
end
