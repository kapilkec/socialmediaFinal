require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'association' do
    context "belongs_to"  do
      let(:user) {create(:user)}
      let(:member) {build(:member , user:user)}
      it "return member is true" do
        expect(member.user).to be_an_instance_of(User)
      end
    end
     context "has_and_belongs_to_many" do

      [:groups].each do |each|
        it each.to_s.humanize do
          association = Member.reflect_on_association(each).macro
          expect(association).to be(:has_and_belongs_to_many)
        end
      end
    end
  end
  describe "validation on interestRating field" do
    context "when interestRating is nil" do
      let(:member) { build(:member, interestRating:nil) }
      before do
        member.save
      end
      it "should return false" do
        expect(member.errors).to include(:interestRating)
      end
    end
    context "when interestRating is present" do
      let(:member) { build(:member) }
      before do
        member.save
      end
      it "should return true" do
        expect(member.errors).to_not include(:interestRating)
      end
    end
  end
end
