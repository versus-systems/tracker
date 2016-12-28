FactoryGirl.define do
  factory :task do
    sequence(:project_id) { SecureRandom.uuid }
    sequence(:id) { SecureRandom.uuid }
    name "Destroy Death Star"
    description "In order to save the Galaxy from a tyrannical and destructive Sith force, we must destroy the Death Star."
    state "todo"
    
  end
end
