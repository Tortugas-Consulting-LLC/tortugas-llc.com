require 'test_helper'

class AboutControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get contributions" do
    get :contributions
    assert_response :success
  end

  test "should get recommendations" do
    get :recommendations
    assert_response :success
  end

end
