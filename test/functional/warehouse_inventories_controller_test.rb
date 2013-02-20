require 'test_helper'

class WarehouseInventoriesControllerTest < ActionController::TestCase
  setup do
    @warehouse_inventory = warehouse_inventories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warehouse_inventories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warehouse_inventory" do
    assert_difference('WarehouseInventory.count') do
      post :create, warehouse_inventory: {  }
    end

    assert_redirected_to warehouse_inventory_path(assigns(:warehouse_inventory))
  end

  test "should show warehouse_inventory" do
    get :show, id: @warehouse_inventory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @warehouse_inventory
    assert_response :success
  end

  test "should update warehouse_inventory" do
    put :update, id: @warehouse_inventory, warehouse_inventory: {  }
    assert_redirected_to warehouse_inventory_path(assigns(:warehouse_inventory))
  end

  test "should destroy warehouse_inventory" do
    assert_difference('WarehouseInventory.count', -1) do
      delete :destroy, id: @warehouse_inventory
    end

    assert_redirected_to warehouse_inventories_path
  end
end
