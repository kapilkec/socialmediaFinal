require 'rails_helper'

RSpec.describe Community, type: :model do

  describe "validation on name field" do
    context "when name is nil" do
      let(:community) {build(:community,name:nil)}
      before do
        community.save
      end
      it "should return false" do
        expect(community.errors).to include(:name)
      end
    end
    context "when name is present" do
      let(:community) {build(:community,name:"name")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:name)
      end
    end
    context "when name is less than 2" do
      let(:community) {build(:community,name:"s")}
      before do
        community.save
      end
      it "should return false" do
        expect(community.errors).to include(:name)
      end
    end
    context "when name is greater than 20" do
      let(:community) {build(:community,name:"12345678901234567890-98")}
      before do
        community.save
      end
      it "should return false" do
        expect(community.errors).to include(:name)
      end
    end
    context "when name is equal to 2 " do
      let(:community) {build(:community,name:"to")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:name)
      end
    end
    context "when name is equal to 20 " do
      let(:community) {build(:community,name:"12345678901234567890")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:name)
      end
    end
    context "when name is greater than 2 and less than 20" do
      let(:community) {build(:community,name:"toss")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:name)
      end
    end
  end

  describe "validation on vision field" do
    context "when visoin is nil" do
      let(:community) {build(:community,vision:nil)}
      before do
        community.save
      end
      it "should return false" do
        expect(community.errors).to include(:vision)
      end
    end
    context "when vision is present" do
      let(:community) {build(:community,vision:"vision")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:vision)
      end
    end
    context "when vision is less than 2" do
      let(:community) {build(:community,vision:"s")}
      before do
        community.save
      end
      it "should return false" do
        expect(community.errors).to include(:vision)
      end
    end
    context "when vision is greater than 20" do
      let(:community) {build(:community,vision:"12345678901234567890-98")}
      before do
        community.save
      end
      it "should return false" do
        expect(community.errors).to include(:vision)
      end
    end
    context "when vision is equal to 2 " do
      let(:community) {build(:community,vision:"to")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:vision)
      end
    end
    context "when vision is equal to 20 " do
      let(:community) {build(:community,vision:"12345678901234567890")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:vision)
      end
    end
    context "when vision is greater than 2 and less than 20" do
      let(:community) {build(:community,vision:"toss")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:vision)
      end
    end
  end

  describe "validation on category field" do
    context "when category is nil" do
      let(:community) {build(:community,category:nil)}
      before do
        community.save
      end
      it "should return false" do
        expect(community.errors).to include(:category)
      end
    end
    context "when category is present" do
      let(:community) {build(:community,category:"category")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:category)
      end
    end
    context "when category is less than 2" do
      let(:community) {build(:community,category:"s")}
      before do
        community.save
      end
      it "should return false" do
        expect(community.errors).to include(:category)
      end
    end
    context "when category is greater than 20" do
      let(:community) {build(:community,category:"12345678901234567890-98")}
      before do
        community.save
      end
      it "should return false" do
        expect(community.errors).to include(:category)
      end
    end
    context "when category is equal to 2 " do
      let(:community) {build(:community,category:"to")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:category)
      end
    end
    context "when category is equal to 20 " do
      let(:community) {build(:community,category:"12345678901234567890")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:category)
      end
    end
    context "when category is greater than 2 and less than 20" do
      let(:community) {build(:community,category:"toss")}
      before do
        community.save
      end
      it "should return true" do
        expect(community.errors).to_not include(:category)
      end
    end
  end

end
