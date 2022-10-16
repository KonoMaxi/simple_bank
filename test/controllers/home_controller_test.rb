require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_in users(:max)
    get root_url
    assert_response :success
  end

  test "should redirect to sign_in" do
    get root_url
    assert_response :found
    assert_redirected_to new_user_session_url
  end
end
