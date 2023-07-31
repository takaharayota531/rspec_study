# require "rails_helper"
#
# RSpec.describe "Tasks",type: :system do
#   scenario "user toggles a task" , js: true do
#     user=FactoryBot.create(:user)
#     project=FactoryBot.create(:project,name:"rspec tutorial",owner: user)
#     task=project.tasks.create!(name:"Finish rspec tutorial")
#
#     visit root_path
#     click_link "Sign in"
#     fill_in "Email" ,with:user.email
#     fill_in "Password",with:user.password
#     click_button "Log in"
#
#     click_link "RSpec tutorial"
#     check "Finish RSpec tutorial"
#
#     expect(page).to have_css "label#task_#{task.id}.completed"
#     expect(task.reload).to be_completed
#
#     uncheck "Finish RSpec tutorial"
#
#     expect(page).not_to have_css "label#task_#{task.id}".completed
#     expect(task.reload).not_to be_completed
#
#
#
#
#
#   end
# end
