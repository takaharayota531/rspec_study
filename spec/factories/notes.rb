FactoryBot.define do
  factory :note do
    message{"My important note."}
    project
    user{project.owner}

  end
end
