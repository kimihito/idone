require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:idoneman)
  end

  test "should create project" do
    assert_difference "Project.count" do
      post projects_url, params: { project: { title: 'Some title' } }
    end

    assert_redirected_to project_path(Project.last)
  end
end