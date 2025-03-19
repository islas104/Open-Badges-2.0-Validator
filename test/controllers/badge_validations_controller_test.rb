require "test_helper"

class BadgeValidationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get badge_validations_new_url
    assert_response :success
  end
end
