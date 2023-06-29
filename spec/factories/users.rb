FactoryBot.define do
  factory :user do
     sequence :email do |n|
      "one#{n}@gmail.com"
    end
    name {"one"}
    password {"123456"}
    password_confirmation {"123456"}
    

  end
end
