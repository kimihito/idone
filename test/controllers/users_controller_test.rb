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
    assert_response :success
  end

  test 'should return not found response when no existed user' do
    with_exceptions_app do
      get user_url(name: 'no-exist-username')
    end

    assert_response :not_found
  end
end
