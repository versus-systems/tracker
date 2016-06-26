FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "#{FFaker::HipsterIpsum.word.parameterize}#{n}" }
    description FFaker::HipsterIpsum.words(2)
  end
end
