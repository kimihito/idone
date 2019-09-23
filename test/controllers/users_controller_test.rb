require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Rambulance::TestHelper

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get show' do
    user = users(:idoneman)
    get user_url(user)
    assert_redirected_to user_overview_url(user)
  end
end
