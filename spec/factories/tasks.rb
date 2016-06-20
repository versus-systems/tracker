FactoryGirl.define do
  factory :task do
    name { Faker::Commerce.product_name }
    description { Faker::Company.catch_phrase }
    state [:active, :pending].sample
  end
end
