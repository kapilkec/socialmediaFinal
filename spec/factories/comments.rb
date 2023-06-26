FactoryBot.define do
  factory :comment do
     commenter  {"sam"}
     comment { "sam comment" }
     user
     post
  end
end
