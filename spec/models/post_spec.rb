require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "validation on title field" do
    context "when title is nil" do
      let(:post) {build(:post,title:nil)}

      before do
        post.save
      end
      it "should return false" do
        expect(post.errors.full_messages).to include("Title can't be blank")
      end
    end

    context "when title is present" do
      let(:post) { build(:post,title:"one") }
      before do
        post.save
      end
      it "should return true" do
        expect(post.errors).to_not include(:title)
      end
    end

    context "when title length is less than 2 " do
      let(:post) { build(:post,title:"e") }
      before do
        post.save
      end
      it "should return false" do
        expect(post.errors.full_messages).to include("Title is too short (minimum is 2 characters)")
      end
    end
    context "when title length is greater than 20 " do
      let(:post) { build(:post,title:"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee") }
      before do
        post.save
      end
      it "should return false" do
        expect(post.errors.full_messages).to include("Title is too long (maximum is 20 characters)")
      end
    end
    context "when title length is greater than 2 and less than 20" do
      let(:post) { build(:post,title:"dffssss") }
      before do
        post.save
      end
      it "should return true" do
        expect(post.errors).to_not include(:title)
      end
    end

  end

  describe "validation on description field" do
        context "when description is nil" do
            let(:post) { build(:post,description:nil) }
            before do
              post.save
            end
            it "should return false" do
              expect(post.errors.full_messages).to include("Description can't be blank")
            end
        end
        context "when description is not nil" do
            let(:post) { build(:post,description:"hello this is description") }
            before do
              post.save
            end
            it "should return true" do
              expect(post.errors).to_not include(:description)
            end
        end
        context "when description length is less than 10" do
            let(:post) { build(:post,description:"one") }
            before do
              post.save
            end
            it "should return false" do
              expect(post.errors).to include(:description)
            end
        end
        context "when description length is greater than 10" do
            let(:post) { build(:post,description:"hi this is desription") }
            before do
              post.save
            end
            it "returns true" do
              expect(post.errors.full_messages).to_not include("Description is too short (minimum is 10 characters)")
            end
        end
        context "when description length is greater than 10 and less than 50" do
            let(:post) { build(:post,description:"hi this is desription") }
            before do
              post.save
            end
            it "should return true" do
              expect(post.errors).to_not include(:description)
            end
        end
  end

  describe 'association' do

    context "belongs_to"  do
      let(:user) {create(:user)}
      let(:post) {build(:post , user:user)}
      it "return post is true" do
        expect(post.user).to be_an_instance_of(User)
      end
    end

    context "has_many" do

      [:comments , :likes].each do |each|
        it each.to_s.humanize do
          association = User.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end

  end
  describe "callbacks" do
      context "randomize_id" do
        let(:post) {build(:post)}
        before do
          post.save
        end
        it "length equal to 9" do
          expect(post.id.to_s.length).to eq(8)
        end
      end
  end

end
