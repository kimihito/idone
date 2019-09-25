require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Rambulance::TestHelper

  test 'should get index' do
    get users_url
    assert_response :success
  end
end
