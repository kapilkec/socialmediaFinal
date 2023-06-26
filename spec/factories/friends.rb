FactoryBot.define do
  factory :friend do
    fromUser {1}
    toUser {2}
    followed {true}
  end
end
