FactoryGirl.define do
  factory :term do
    value "pie"
    base_value "pie"
  end

  factory :term_with_different_base_value, class: Term do
    value "cakes"
    base_value "cake"
  end
end
