require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:idoneman)
  end

  test 'all user can show' do
    visit user_url(@user)
    assert_text @user.name
  end

  test 'login user can show edit button in same user page' do
    sign_in(@user)
    visit user_url(@user)
    assert_button '編集'
  end
end
