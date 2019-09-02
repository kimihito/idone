require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get show' do
    user = users(:idoneman)
    get user_url(user)
    assert_response :success
  end
end
