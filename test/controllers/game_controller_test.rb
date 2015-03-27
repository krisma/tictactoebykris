require 'test_helper'

class GameControllerTest < ActionController::TestCase
  test "should get single" do
    get :single
    assert_response :success
  end

  test "should get multi" do
    get :multi
    assert_response :success
  end

end
