FactoryGirl.define do
  factory :task do
    name
    description 'A sample task'
    project
  end
end
