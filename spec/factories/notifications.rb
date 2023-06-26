FactoryBot.define do
  factory :notification do
    hasRead {true}
    user
    friend
  end
end
