require "rails_helper"

RSpec.describe "Users" do
  it "sign up" do
    FactoryBot.create(:user)

    visit root_path
    click_link "Sign up"
    expect  do
      MSG = "yota.takahara@techouse.jp".freeze

      fill_in "First name", with: MSG
      fill_in "Last name", with: MSG
      fill_in "Email", with: MSG
      fill_in "Password", with: MSG
      fill_in "Password confirmation", with: MSG
      click_button "Sign up"
    end.to change(User, :count).by(1)
    # click_button "Sign Out"
  end
end
