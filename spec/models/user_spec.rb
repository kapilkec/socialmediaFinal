require 'rails_helper'

RSpec.describe User, type: :model do

   describe 'association' do

    context "has_many" do

      [:likes , :groups , :posts , :comments, :notifications].each do |each|
        it each.to_s.humanize do
          association = User.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end



    context "has_one" do
      [:story,:latest_notification].each do |each|
        it "story" do
          association = User.reflect_on_association(each).macro
          expect(association).to be(:has_one)
        end
      end
    end

  end

  describe "Validation on email field" do

    context "when email is nill" do
      let(:user) {build(:user,email:nil)}
      before do
        user.save
      end
      it "should return false" do
        expect(user.errors).to include(:email)
      end
    end

    context "when email is in wrong format" do
      let(:user) {build(:user,email:"kapil")}
      before do
        user.save
      end
      it "should return false" do
        expect(user.errors).to include(:email)
      end
    end

    context "when email is empty" do
      let(:user) {build(:user,email:"")}
      before do
        user.save
      end
      it "should return false" do
        expect(user.errors).to include(:email)
      end
    end

    context "when email is correct" do
      let(:user) {build(:user)}
      before do
        user.save
      end
      it "should return true" do
        expect(user.errors).to_not include(:email)
      end
    end

  end
  describe "Validation on Password field" do

    context "when password is nil" do
      let(:user) {build(:user,password:nil,password_confirmation:nil)}

      before do
        user.save
      end

      it "should return false" do
        expect(user.errors).to include(:password)
      end
    end

    context "when password is empty" do
      let(:user) {build(:user,password:"",password_confirmation:"")}

      before do
        user.save
      end

      it "should return false" do
        expect(user.errors).to include(:password)
      end
    end

    context "when password is less than 6 charaters" do
      let(:user) {build(:user,password:"123",password_confirmation:"123")}

      before do
        user.save
      end

      it "should return false" do
        expect(user.errors).to include(:password)
      end
    end

    context "when password doesnot matches password confirmation" do

      let(:user) {build(:user,password:"123456",password_confirmation:"1234567")}

      before do
        user.save
      end

      it "should return false" do
        expect(user.errors).to include(:password_confirmation)
      end
    end

    context "when password is greater than or equal to 6 charaters" do
      let(:user) {build(:user)}

      before do
        user.save
      end

      it "should return true" do
        expect(user.errors).to_not include(:password)
      end
    end

  end

end
