FactoryBot.define do
  factory :post do
    user
    title {"title"}
    description {"description"}
    privacy {"public"}
  end
end
