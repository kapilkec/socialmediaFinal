require "test_helper"

class StorysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get storys_index_url
    assert_response :success
  end

  test "should get delete" do
    get storys_delete_url
    assert_response :success
  end
end
