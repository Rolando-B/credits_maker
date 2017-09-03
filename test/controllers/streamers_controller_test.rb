require 'test_helper'

class StreamersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get streamers_new_url
    assert_response :success
  end

end
