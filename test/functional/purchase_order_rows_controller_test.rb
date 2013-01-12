require 'test_helper'

class PurchaseOrderRowsControllerTest < ActionController::TestCase
  setup do
    @purchase_order_row = purchase_order_rows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_order_rows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_order_row" do
    assert_difference('PurchaseOrderRow.count') do
      post :create, purchase_order_row: { line_amount: @purchase_order_row.line_amount, name: @purchase_order_row.name, order_quantity: @purchase_order_row.order_quantity, row_number: @purchase_order_row.row_number, unit_cost: @purchase_order_row.unit_cost }
    end

    assert_redirected_to purchase_order_row_path(assigns(:purchase_order_row))
  end

  test "should show purchase_order_row" do
    get :show, id: @purchase_order_row
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_order_row
    assert_response :success
  end

  test "should update purchase_order_row" do
    put :update, id: @purchase_order_row, purchase_order_row: { line_amount: @purchase_order_row.line_amount, name: @purchase_order_row.name, order_quantity: @purchase_order_row.order_quantity, row_number: @purchase_order_row.row_number, unit_cost: @purchase_order_row.unit_cost }
    assert_redirected_to purchase_order_row_path(assigns(:purchase_order_row))
  end

  test "should destroy purchase_order_row" do
    assert_difference('PurchaseOrderRow.count', -1) do
      delete :destroy, id: @purchase_order_row
    end

    assert_redirected_to purchase_order_rows_path
  end
end
