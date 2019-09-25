require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  def setup
    @user = users(:idoneman)
    @no_track_and_project_user = users(:no_track_and_project_user)
  end

  test 'all user can show' do
    visit user_overview_url(@user)
    assert_text @user.name
    assert_text I18n.l(@user.created_at.to_date)
    assert_text "#{I18n.t('components.users.show.navigation.track')}#{@user.tracks.size}"
    assert_text "#{I18n.t('components.users.show.navigation.project')}#{@user.projects.size}"
  end

  test 'login user can show edit button in same user page' do
    login_as(@user, scope: :user)
    visit user_overview_url(@user)
    assert_text I18n.t('components.users.show.layout.edit_profile')
  end

  test 'display empty state user has no track' do
    visit user_overview_url(@no_track_and_project_user)
    assert_text "#{I18n.t('components.users.show.navigation.track')}#{@no_track_and_project_user.tracks.size}"
    assert_text "#{I18n.t('components.users.show.navigation.project')}#{@no_track_and_project_user.projects.size}"
    assert_text I18n.t('components.empty_state.track.header')
  end

  test 'display new project button in same user page' do
    login_as(@no_track_and_project_user, scope: :user)
    visit user_overview_url(@no_track_and_project_user)
    assert_text I18n.t('components.empty_state.project.new_link')
  end
end
