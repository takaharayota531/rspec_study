# require "rails_helper"
#
# RSpec.describe "Tasks",type: :system do
#
#   let(:user) {FactoryBot.create(:user)}
#   let(:project){FactoryBot.create(:project,name:"rspec tutorial",owner: user)}
#   let!(:task){project.tasks.create!(name:"Finish rspec tutorial")}
#
#   scenario "user toggles a task" , js: true do
#     # user=FactoryBot.create(:user)
#     # project=FactoryBot.create(:project,name:"rspec tutorial",owner: user)
#     # task=project.tasks.create!(name:"Finish rspec tutorial")
#
#     sign_in user
#
#     go_to_project("RSpec tutorial")
#
#     complete_task "Finish RSpec tutorial"
#
#
#
#
#     expect_complete_task "Finish RSpec tutorial"
#     undo_complete_task "Finish RSpec tutorial"
#
#     expect_incomplete_task "Finish RSpec tutorial"
#
#   end
#
#   def go_to_project(name)
#     visit root_path
#     click_link name
#   end
#
#   def complete_task(name)
#     check name
#   end
#
#   def undo_complete_task(name)
#     uncheck name
#   end
#
#   def expect_complete_task(name)
#     aggregate_failures do
#
#
#     expect(page).to have_css "label.completed",text:name
#     expect(task.reload).to be_completed
#     end
#   end
#
#   def expect_incomplete_task(name)
#     aggregate_failures do
#
#
#     expect(page).not_to have_css "label.completed",text:name
#     expect(task.reload).not_to be_completed
#     end
#   end
# end
