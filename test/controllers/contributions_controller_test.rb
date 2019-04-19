require 'test_helper'

class ContributionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:idoneman)
    @project = projects(:project_1)
    sign_in @user
  end

  test "should create contribution" do
    assert_difference "Contribution.count" do
      post contributions_url, params: { contribution: { raw_body: "##{@project.title} contribution", owner: @user }}
    end

    assert_equal Contribution.last.raw_body, "##{@project.title} contribution"
    assert_equal @project, Contribution.last.project
  end
end
