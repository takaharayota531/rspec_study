require 'rails_helper'

RSpec.describe TasksController do

  include_context "project setup"

  describe "#show" do

    it "responds with json formatted output" do
      sign_in user
      get :show ,format: :json ,
          params:{
            project_id:project.id,id: task.id
          }
      # expect(response.content_type).to include "application/json"
      expect(response).to have_content_type :json

    end

  end

  describe "#create" do

    # json形式でレスポンスを返すこと
    it "responds with json formatted output" do
      new_task={name:"new task name" }
      sign_in user

      post :create,format: :json,
           params:{
             project_id: project.id,
             task:new_task
           }
      # expect(response.content_type).to include "application/json"
      expect(response).to have_content_type :json
    end

    it "adds a new task to the project" do
      new_task={name:"new task name" }
      sign_in user

      expect{post :create,format: :json,
           params:{
             project_id: project.id,
             task:new_task
           }
      }.to change(project.tasks,:count).by(1)
    end

    it "requires authentication" do
      new_task={name:"new task name" }
      expect{
        post :create,format: :json,
             params:{
               project_id:project.id,
               task:new_task}
             }.not_to change(project.tasks,:count)
      expect(response).not_to be_successful

    end

  end

end
