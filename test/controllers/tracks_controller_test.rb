require 'test_helper'

class TracksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:idoneman)
    @project = projects(:project_1)
    sign_in @user
  end

  test "should create track" do
    assert_difference "Track.count" do
      post tracks_url, params: { track: { raw_body: "##{@project.title} track", owner_id: @user.id, project_id: @project.id }}
    end

    assert_equal Track.recent.first.raw_body, "##{@project.title} track"
    assert_equal @project, Track.recent.first.project
  end
end
