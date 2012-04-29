FactoryGirl.define do
  factory :user do |f|
    sequence(:name){|n| "user_#{n}"}
    sequence(:email){|n| "user_#{n}@example.com" }
    private false
    encrypted_password "junk"
    sign_in_count 1
    current_sign_in_at Time.now
    last_sign_in_at Time.now - 1.day
    password "testtest"
    
  end
end
