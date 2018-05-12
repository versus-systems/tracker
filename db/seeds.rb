# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 
project = Project.create(name: "Sample Project")

5.times do |index|
  task = Task.create(name: "Sample task #{index}", 
    description: "This is a sample task",
    project_id: project.id)
end