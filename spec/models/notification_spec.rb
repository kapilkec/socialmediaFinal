require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'association' do

    context "belongs_to"  do
      let(:user) {create(:user)}
      let(:notification) {build(:notification , user:user)}
      it "return notification is true" do
        expect(notification.user).to be_an_instance_of(User)
      end
    end

    context "belongs_to"  do
      let(:friend) {create(:friend)}
      let(:notification) {build(:notification , friend:friend)}
      it "return notification is true" do
        expect(notification.friend).to be_an_instance_of(Friend)
      end
    end
  end

  describe "validation on hasRead attribute" do
    context "when a new notification is created" do
      let(:notification) { Notification.new }

      it "has hasRead set to true by default" do
        expect(notification.hasRead).to be false
      end
    end
    context "when a new notification is created" do
      let(:notification) { Notification.new }

      it "has hasRead set to true by default" do
        expect(notification.hasRead).to_not be true
      end
    end
  end
end
