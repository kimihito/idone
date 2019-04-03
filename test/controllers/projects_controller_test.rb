require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:idoneman)
    sign_in @user
  end

  test "should create project" do
    assert_difference "Project.count" do
      post projects_url, params: { project: { title: 'Some title', owner: @user } }
    end
    assert_redirected_to project_path(Project.find_by(title: "Some title"))
    assert_equal I18n.t('projects.create.success'), flash[:notice]
  end
end