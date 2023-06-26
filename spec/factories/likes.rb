FactoryBot.define do
  factory :like do

      trait :for_post do
        association :likeable, factory: :post
      end

      trait :for_comment do
        association :likeable ,factory: :comment

      end
      user
  end
end
