FactoryBot.define do
  factory :story do
    user
    note { "note" }
    expiration_time { Time.now + 1.day }

  end
end
