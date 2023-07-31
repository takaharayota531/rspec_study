require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:project) { FactoryBot.create(:project) }

  it "is valid with a project and name" do
    task = Task.new(
      project:,
      name: "test"
    )

    expect(task).to be_valid
  end

  it "is invalid without project" do
    task = Task.new(
      project: nil,
      name: "test"
    )

    expect(task).not_to be_valid
    expect(task.errors[:project]).to include("must exist")
  end

  it "is invalid without name" do
    task = Task.new(
      name: nil
    )

    expect(task).not_to be_valid
    expect(task.errors[:name]).to include("can't be blank")
  end
end
