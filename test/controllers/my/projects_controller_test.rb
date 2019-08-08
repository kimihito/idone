require 'test_helper'

class My::ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :users, :projects

  setup do
    @project = projects(:project_1)
    @user = users(:idoneman)
  end

  test "should get index" do
    sign_in(@user)
    get my_projects_url, as: :json
    assert_response :success
  end
end