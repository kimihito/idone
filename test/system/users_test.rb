require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:idoneman)
    @no_track_user = users(:no_track_user)
  end

  test 'all user can show' do
    visit user_url(@user)
    assert_text @user.name
    assert_text @user.created_at
    assert_text "#{@user.tracks.size} Done"
    assert_text "#{@user.projects.size} Projects"
  end

  test 'login user can show edit button in same user page' do
    sign_in(@user)
    visit user_url(@user)
    assert_button '編集'
  end

  test 'display empty state user has no track' do
    visit user_url(@no_track_user)
    assert_text "#{@no_track_user.tracks.size} Done"
    assert_text "No Done"
  end
end
