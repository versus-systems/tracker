FactoryGirl.define do
  factory :task do
    sequence(:name) { |n| "#{FFaker::HipsterIpsum.word.parameterize}#{n}" }
    description FFaker::HipsterIpsum.words(2)
    state [0,1,2].sample
    project
  end
end
