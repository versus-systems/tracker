FactoryGirl.define do
  factory :task do
    name "My new task"
    description "I will do this and I will do that."
    project_id "b059934-5c03-4e2d-a25a-d373654d505c"
    state 10
  end
end
