require 'rails_helper'

RSpec.describe Project, type: :model do

  it "does not allow duplicate project depending on user"do
    user= User.create(
      first_name: "Aaronq",
      last_name: "Sumnerq",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
      )

    user.projects.create(
      name:"test project",
    )
    new_project=user.projects.build(
      name:"test project",
    )

    expect(new_project).not_to be_valid
    expect(new_project.errors[:name]).to include("has already been taken")

  end

  it "allows two users to share a same project name" do
    user= User.create(
      first_name: "Aaronq",
      last_name: "Sumnerq",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
      )
    user1= User.create(
      first_name: "Aaronq1",
      last_name: "Sumnerq1",
      email: "tester1@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
      )
    user.projects.create(
      name:"test project",
      )
    new_project=user1.projects.build(
      name:"test project",
      )

    expect(new_project).to be_valid
    # expect(new_project.errors[:name]).to include("has already been taken")

  end
end
