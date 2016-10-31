FactoryGirl.define do
  factory :task do
    project
    name "MyString"
    description "MyText"
    state 1
  end
end
