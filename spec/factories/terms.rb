FactoryGirl.define do
  factory :term do
    value "word"
    phrase :false
    after_create do |t|
      t.users << FactoryGirl.create(:user)
      t.definitions << FactoryGirl.create(:definition)
    end
  end
end
