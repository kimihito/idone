require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  def setup
    @project = projects(:project_1)
  end

  test 'login user can show edit button in owner project page' do
    login_as(users(:idoneman), scope: :user)
    visit project_url(@project)
    assert_text I18n.t('components.projects.show.layout.edit')
  end
end