require 'test_helper'

class MultigamesControllerTest < ActionController::TestCase
  setup do
    @multigame = multigames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:multigames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create multigame" do
    assert_difference('Multigame.count') do
      post :create, multigame: { player1: @multigame.player1, player2: @multigame.player2, status: @multigame.status, turn: @multigame.turn }
    end

    assert_redirected_to multigame_path(assigns(:multigame))
  end

  test "should show multigame" do
    get :show, id: @multigame
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @multigame
    assert_response :success
  end

  test "should update multigame" do
    patch :update, id: @multigame, multigame: { player1: @multigame.player1, player2: @multigame.player2, status: @multigame.status, turn: @multigame.turn }
    assert_redirected_to multigame_path(assigns(:multigame))
  end

  test "should destroy multigame" do
    assert_difference('Multigame.count', -1) do
      delete :destroy, id: @multigame
    end

    assert_redirected_to multigames_path
  end
end
