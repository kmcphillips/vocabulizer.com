FactoryGirl.define do
  factory :definition do
    body "the definition"
    example "the example"
  end

  factory :urban_definition, :parent => :definition do

  end
end
