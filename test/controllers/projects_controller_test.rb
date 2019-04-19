require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :users, :projects

  setup do
    @project = projects(:project_1)
    @user = users(:idoneman)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    sign_in(@user)
    get new_project_url
    assert_response :success
  end

  test "should create project" do
    sign_in(@user)

    assert_difference('Project.count') do
      post projects_url, params: { project: { title: 'title', owner: @user } }
    end

    assert_redirected_to project_url(Project.recent.first)
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    sign_in(@user)
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    sign_in(@user)
    patch project_url(@project), params: { project: { title: 'hi' } }
    assert_redirected_to project_url(@project)
    assert @project.title, 'hi'
  end

  test "should destroy project" do
    sign_in(@user)
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end
end
