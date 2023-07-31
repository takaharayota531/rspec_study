require 'rails_helper'

RSpec.describe "Projects API", type: :request do

  context "with #get" do
  before(:each) do
    @user=FactoryBot.create(:user)
    FactoryBot.create(:project,name:"sample project")
    FactoryBot.create(:project,name:"second sample project",owner:@user)
  end

  it "loads a project" do


    get api_projects_path,params:{
      user_email:@user.email,
      user_token: @user.authentication_token
    }

    expect(response).to have_http_status(:success)
    json=JSON.parse(response.body)
    expect(json.length).to eq 1
    # puts json
    project_id=json[0]["id"]

    get api_project_path(project_id),params:{
      user_email:@user.email,
      user_token:@user.authentication_token
    }
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json["name"]).to eq "second sample project"
    # puts json


    # get api_project_path(project_id),params:{
    #   user_email:user.email,
    #   user_token: user.authentication_token
    # }
    #
  end
  end
  context "with #update" do
    before(:each) do
      @user=FactoryBot.create(:user)
    end
    it "creates a project" do
      project_attributes=FactoryBot.attributes_for(:project)

      expect{
        post api_projects_path,params:{
          user_email:@user.email,
          user_token:@user.authentication_token,
          project:project_attributes
        }
      }.to change(@user.projects,:count).by(1)

      expect(response).to have_http_status(:success)



    end
  end
end
