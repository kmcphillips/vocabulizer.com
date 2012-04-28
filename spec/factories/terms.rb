# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :term do
    value "word"
    phrase :false
    association :user
  end
end
