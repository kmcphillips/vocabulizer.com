FactoryGirl.define do
  factory :user do
    email "user@example.com"
    username "example_user"
    password "asdfasdf"
    password_confirmation "asdfasdf"
  end
end
