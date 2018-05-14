
3.times do |p|
    project = Project.create(name: "Sample Project #{p}")

    4.times do |t|
    task = Task.create(name: "Sample task #{t}", 
        description: "This is a sample task",
        project_id: project.id)
    end
end