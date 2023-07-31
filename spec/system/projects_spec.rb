require 'rails_helper'

RSpec.describe "Projects" do
  # include  LoginSupport
  it "user creates a new project" do
    user = FactoryBot.create(:user)

    sign_in user
    visit root_path

    expect do
      click_link "New Project"
      fill_in "Name", with: "Test Project"
      fill_in "Description", with: "Trying out Capybara"
      click_button "Create Project"


    end.to change(user.projects, :count).by(1)
    aggregate_failures do
      expect(page).to have_content "Project was successfully created"
      expect(page).to have_content "Test Project"
      expect(page).to have_content "Owner: #{user.name}"
    end
  end
  # scenario "guest adds a project" do
  #   visit projects_path
  #   # save_and_open_page
  #   click_link "New Project"
  # end
end
