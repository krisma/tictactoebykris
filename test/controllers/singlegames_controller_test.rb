require 'test_helper'

class SinglegamesControllerTest < ActionController::TestCase
  setup do
    @singlegame = singlegames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:singlegames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create singlegame" do
    assert_difference('Singlegame.count') do
      post :create, singlegame: { status: @singlegame.status, turn: @singlegame.turn }
    end

    assert_redirected_to singlegame_path(assigns(:singlegame))
  end

  test "should show singlegame" do
    get :show, id: @singlegame
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @singlegame
    assert_response :success
  end

  test "should update singlegame" do
    patch :update, id: @singlegame, singlegame: { status: @singlegame.status, turn: @singlegame.turn }
    assert_redirected_to singlegame_path(assigns(:singlegame))
  end

  test "should destroy singlegame" do
    assert_difference('Singlegame.count', -1) do
      delete :destroy, id: @singlegame
    end

    assert_redirected_to singlegames_path
  end
end
