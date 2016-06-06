FactoryGirl.define do
  factory :project do
    name { Faker::Commerce.product_name }
    description { Faker::Company.catch_phrase }
  end
end
