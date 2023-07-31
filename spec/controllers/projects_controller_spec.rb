require 'rails_helper'

RSpec.describe ProjectsController do

  describe "#index" do
    # 認証済みのユーザーとして
    context "as an authenticated user" do
  before do
    @user=FactoryBot.create(:user)
  end

  it "responds successfully" do
    sign_in @user
    get :index
    expect(response).to be_successful
  end

  it "returns a 200" do
    sign_in @user
    get :index
    expect(response).to have_http_status "200"
  end
    end

    # 認証されていないユーザーの場合
    context  "as a guest" do
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page"do
        get :index
        expect(response).to redirect_to new_user_session_path
      end

    end

  end

  describe "#show"do

    context "as an authorized user" do
      before do
        @user=FactoryBot.create(:user)
        @project=FactoryBot.create(:project,owner: @user)
      end

      it "responds correctly" do
        sign_in @user
        get :show ,params:{id:@project.id}
        expect(response).to be_successful

      end



    end

    context "as an unauthorized user" do
      before do
        @user=FactoryBot.create(:user)
        other_user=FactoryBot.create(:user)
        @other_project=FactoryBot.create(:project,owner:other_user)

      end

      # 異なるユーザーでログインした時はroot画面にリダイレクトされる
      it "redirects to the dashboard" do
        sign_in @user
        get :show,params:{id:@other_project.id}
        expect(response).to redirect_to root_path
      end

    end

  end

  describe "#new" do
    context "as an authorized user" do
    before do
      @user=FactoryBot.create(:user)
    end

    it "responds correctly" do
      sign_in @user
      get :new
      expect(response).to be_successful
    end

    it "responds correct http status" do
      sign_in @user
      get :new
      expect(response).to have_http_status "200"
    end

    end

    context "as a guest" do
      before do
        @user=FactoryBot.create(:user)

      end

      it "returns 302 http status" do
        get :new
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

  describe "#create" do
    context "as an authenticated user"do
      before do
        @user=FactoryBot.create(:user)

      end

      # 有効な属性値の場合
      context "with valid attributes" do
      # プロジェクトを追加できること
      it "adds a project" do
        project_params=FactoryBot.attributes_for(:project)
        sign_in @user
        expect{post :create,params:{
          project:project_params}
        }.to change(@user.projects,:count).by(1)
      end
      end

      context "with invalid attributes" do
        it "does not add a project" do
          project_params=FactoryBot.attributes_for(:project,:invalid_name)
          sign_in @user
           expect{post :create,params:{
             project:project_params}
          }.not_to change(@user.projects,:count)

        end
      end
      end

      context "as a guest" do
        it "returns a 302 response"do
          project_params=FactoryBot.attributes_for(:project)
          post :create,params:{
            project:project_params
          }
          expect(response).to have_http_status "302"

        end

        it "redirects to the root page" do
          project_params=FactoryBot.attributes_for(:project)
          post :create,params:{
            project:project_params
          }
          expect(response).to redirect_to new_user_session_path
        end
      end

  end

  describe "#edit" do
    context "as an authorized user" do
      before do
        @user=FactoryBot.create(:user)
        @project=FactoryBot.create(:project,owner: @user)
      end

      it "responds correctly" do
        sign_in @user
        get :edit,params:{id:@project.id}
        expect(response).to be_successful
      end

      it "responds correct http status" do
        sign_in @user
        get :edit,params:{id:@project.id}
        expect(response).to have_http_status "200"
      end
    end

    context "as an unauthorized user" do
      before do
        @user=FactoryBot.create(:user)
        other_user=FactoryBot.create(:user)
        @other_project=FactoryBot.create(:project,owner:other_user,name: "other user")
      end

      it "does not update the project" do

        sign_in @user
        get :edit ,params:{id: @other_project.id}
        expect(response).to have_http_status "302"
      end

      it "redirects to the dashboards" do

        sign_in @user
        get :edit ,params:{id: @other_project.id}
        expect(response).to redirect_to root_path
      end

    end

    context "as a guest" do
      before do
        @project=FactoryBot.create(:project)
      end

      # 302レスポンスを返すこと
      it "returns a 302 status" do

        get :edit,params:{
          id:@project.id
        }
        expect(response).to have_http_status "302"

      end

      it "redirects to the root page" do
        # project_params=attributes_for(:project)
        get :edit,params:{
          id:@project.id
        }
        expect(response).to   redirect_to new_user_session_path
      end
    end

  end

  describe "#update"do
    context "as an authorized user" do
      before do
        @user=FactoryBot.create(:user)
        @project=FactoryBot.create(:project,owner: @user)
      end


      it "updates a project" do
        project_params=FactoryBot.attributes_for(:project,name: "shinnshinn")
        sign_in @user
        patch :update ,params:{id: @project.id,project:project_params}
        expect(@project.reload.name).to eq "shinnshinn"
      end
      end


    context "as an unauthorized user" do
      before do
        @user=FactoryBot.create(:user)
        other_user=FactoryBot.create(:user)
        @other_project=FactoryBot.create(:project,owner:other_user,name: "other user")

      end

      it "does not update the project" do
        project_params=FactoryBot.attributes_for(:project,name: "shinnshinn")
        sign_in @user
        patch :update ,params:{id: @other_project.id,project:project_params}
             expect(@other_project.reload.name).to eq "other user"



      end


      # 異なるユーザーでログインした時はroot画面にリダイレクトされる
      it "redirects to the dashboard" do
        project_params=FactoryBot.attributes_for(:project,name: "shinnshinn")
        sign_in @user
        patch :update ,params:{id: @other_project.id,project:project_params}
        expect(response).to redirect_to root_path

      end

    end

    context "as a guest" do
      before do
        @project=FactoryBot.create(:project)
      end

      # 302レスポンスを返すこと
      it "returns a 302 status" do
        project_params=FactoryBot.attributes_for(:project)
        patch :update,params:{
          id:@project.id,
          project:project_params
        }
        expect(response).to have_http_status "302"

      end

      it "redirects to the root page" do
           project_params=FactoryBot.attributes_for(:project)
        patch :update,params:{
          id:@project.id,
          project:project_params
        }
        expect(response).to   redirect_to new_user_session_path
      end
    end

  end

  describe "#destroy" do
    context "as an authorized user" do
      before do
        @user=FactoryBot.create(:user)
        @project=FactoryBot.create(:project,owner: @user)
      end


      it "destroys a project" do
        # project_params=FactoryBot.attributes_for(:project,name: "shinnshinn")
        sign_in @user
        expect{delete :destroy ,params:{id:@project.id}
        }.to change(@user.projects,:count).by(-1)


      end
    end

    context "as an unauthorized user" do
      before do
        @user=FactoryBot.create(:user)
        other_user=FactoryBot.create(:user)
        @other_project=FactoryBot.create(:project,owner:other_user,name: "other user")

      end

      it "does not destroy the project" do
        sign_in @user
        expect{
          delete :destroy ,params:{id: @other_project.id}
        }.not_to change(Project,:count)
      end

      # 異なるユーザーでログインした時はroot画面にリダイレクトされる
      it "redirects to the dashboard" do
        # project_params=FactoryBot.attributes_for(:project,name: "shinnshinn")
        sign_in @user
        delete :destroy ,params:{id: @other_project.id}
        expect(response).to redirect_to root_path
      end
    end

    context "as a guest" do
      before do
        @project=FactoryBot.create(:project)
      end

      # 302レスポンスを返すこと
      it "returns a 302 status" do
        delete :destroy ,params:{id: @project.id}
        expect(response).to have_http_status "302"

      end

      it "redirects to the root page" do
        # project_params=FactoryBot.attributes_for(:project)
        delete :destroy ,params:{id: @project.id}
        expect(response).to redirect_to new_user_session_path
      end

      it "does not destroy the project" do

        expect{
          delete :destroy ,params:{id: @project.id}
        }.not_to change(Project,:count)
      end

    end

  end




end