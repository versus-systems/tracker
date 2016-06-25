FactoryGirl.define do
  factory :project do
    name
    description 'A sample project'

  trait :with_tasks do 
      after(:create) do |project, evaluator|
        FactoryGirl.create_list(:task, 1, project: project)
      end
    end
  end

  factory :task do 
    name 'Task Name'
    description 'Description'
  end
end
