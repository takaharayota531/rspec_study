require 'rails_helper'

RSpec.describe TasksController do

  before do
    @user=FactoryBot.create(:user)
    @project=FactoryBot.create(:project,owner: @user)
    @task=@project.tasks.create!(name: "test task")
  end

  describe "#show" do

    it "responds with json formatted output" do
      sign_in @user
      get :show ,format: :json ,
          params:{
            project_id:@project.id,id: @task.id
          }
      expect(response.content_type).to include "application/json"

    end

  end

  describe "#create" do

    # json形式でレスポンスを返すこと
    it "responds with json formatted output" do
      new_task={name:"new task name" }
      sign_in @user
      expect{
      post :create,format: :json,
           params:{
             project_id: @project.id,
             task:new_task
           }
      }.to change(@project.tasks,:count).by(1)
    end

    it "requires authentication" do
      new_task={name:"new task name" }
      expect{
        post :create,format: :json,
             params:{
               project_id:@project.id,
               task:new_task}
             }.not_to change(@project.tasks,:count)
      expect(response).not_to be_successful

    end

  end

end
