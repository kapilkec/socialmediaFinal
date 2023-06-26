require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'association' do
    context "belongs_to"  do
      let(:user) {create(:user)}
      let(:group) {build(:group , user:user)}
      it "return group is true" do
        expect(group.user).to be_an_instance_of(User)
      end
    end
    context "belongs_to"  do
      let(:community) {create(:community)}
      let(:group) {build(:group , community:community)}
      it "return group is true" do
        expect(group.community).to be_an_instance_of(Community)
      end
    end
    context "has_and_belongs_to_many" do

      [:members].each do |each|
        it each.to_s.humanize do
          association = Group.reflect_on_association(each).macro
          expect(association).to be(:has_and_belongs_to_many)
        end
      end
    end
  end

  describe "validation on name field" do
    context "when name is nil" do

      let(:group) { build(:group, name:nil) }
      before do
        group.save
      end
      it "should return false" do
        expect(group.errors).to include(:name)
      end
    end
    context "when name is present" do
      let(:group) { build(:group) }
      before do
        group.save
      end
      it "should return true" do
        expect(group.errors).to_not include(:name)
      end
    end
    context "when name is less than 2" do
      let(:group) {build(:group,name:"s")}
      before do
        group.save
      end
      it "should return false" do
        expect(group.errors).to include(:name)
      end
    end
    context "when name is greater than 20" do
      let(:group) {build(:group,name:"12345678901234567890-98")}
      before do
        group.save
      end
      it "should return false" do
        expect(group.errors).to include(:name)
      end
    end
    context "when name is equal to 2 " do
      let(:group) {build(:group,name:"to")}
      before do
        group.save
      end
      it "should return true" do
        expect(group.errors).to_not include(:name)
      end
    end
    context "when name is equal to 20 " do
      let(:group) {build(:group,name:"12345678901234567890")}
      before do
        group.save
      end
      it "should return true" do
        expect(group.errors).to_not include(:name)
      end
    end
    context "when name is greater than 2 and less than 20" do
      let(:group) {build(:group,name:"toss")}
      before do
        group.save
      end
      it "should return true" do
        expect(group.errors).to_not include(:name)
      end
    end
  end

  describe "validation on bio field" do
    context "when bio is nil" do
      let(:group) {build(:group,bio:nil)}
      before do
        group.save
      end
      it "should return false" do
        expect(group.errors).to include(:bio)
      end
    end
    context "when bio is present" do
      let(:group) {build(:group,bio:"bio")}
      before do
        group.save
      end
      it "should return true" do
        expect(group.errors).to_not include(:bio)
      end
    end
    context "when bio is less than 2" do
      let(:group) {build(:group,bio:"s")}
      before do
        group.save
      end
      it "should return false" do
        expect(group.errors).to include(:bio)
      end
    end
    context "when bio is greater than 20" do
      let(:group) {build(:group,bio:"12345678901234567890-98")}
      before do
        group.save
      end
      it "should return false" do
        expect(group.errors).to include(:bio)
      end
    end
    context "when bio is equal to 2 " do
      let(:group) {build(:group,bio:"to")}
      before do
        group.save
      end
      it "should return true" do
        expect(group.errors).to_not include(:bio)
      end
    end
    context "when bio is equal to 20 " do
      let(:group) {build(:group,bio:"12345678901234567890")}
      before do
        group.save
      end
      it "should return true" do
        expect(group.errors).to_not include(:bio)
      end
    end
    context "when bio is greater than 2 and less than 20" do
      let(:group) {build(:group,bio:"toss")}
      before do
        group.save
      end
      it "should return true" do
        expect(group.errors).to_not include(:bio)
      end
    end
  end

end
