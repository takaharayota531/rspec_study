require 'rails_helper'

RSpec.describe Project do

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

  describe  "late status" do

    # 締切日が過ぎていれば遅延
    it "is late when the due date is past today" do
      project=FactoryBot.create(:project,:due_yesterday)
      expect(project).to be_late
    end

    # 締切日が今日
    it "is on time when the due date is today" do
      project=FactoryBot.create(:project,:due_today)
      expect(project).not_to be_late
    end

    # 締切日が未来ならスケジュールどおりであること
    it "is on time when the due date is in the future" do
      project=FactoryBot.create(:project,:due_tomorrow)
      expect(project).not_to be_late
    end
  end

  it "can have many notes" do
    project=FactoryBot.create(:project,:with_notes)
    expect(project.notes.length).to eq 5
  end
end
