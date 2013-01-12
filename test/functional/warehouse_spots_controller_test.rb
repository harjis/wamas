require 'test_helper'

class WarehouseSpotsControllerTest < ActionController::TestCase
  setup do
    @warehouse_spot = warehouse_spots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warehouse_spots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warehouse_spot" do
    assert_difference('WarehouseSpot.count') do
      post :create, warehouse_spot: { level: @warehouse_spot.level, position: @warehouse_spot.position, row: @warehouse_spot.row }
    end

    assert_redirected_to warehouse_spot_path(assigns(:warehouse_spot))
  end

  test "should show warehouse_spot" do
    get :show, id: @warehouse_spot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @warehouse_spot
    assert_response :success
  end

  test "should update warehouse_spot" do
    put :update, id: @warehouse_spot, warehouse_spot: { level: @warehouse_spot.level, position: @warehouse_spot.position, row: @warehouse_spot.row }
    assert_redirected_to warehouse_spot_path(assigns(:warehouse_spot))
  end

  test "should destroy warehouse_spot" do
    assert_difference('WarehouseSpot.count', -1) do
      delete :destroy, id: @warehouse_spot
    end

    assert_redirected_to warehouse_spots_path
  end
end
