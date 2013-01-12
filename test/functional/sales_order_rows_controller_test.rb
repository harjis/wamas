require 'test_helper'

class SalesOrderRowsControllerTest < ActionController::TestCase
  setup do
    @sales_order_row = sales_order_rows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sales_order_rows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sales_order_row" do
    assert_difference('SalesOrderRow.count') do
      post :create, sales_order_row: { discount_amount: @sales_order_row.discount_amount, discount_percent: @sales_order_row.discount_percent, line_amount: @sales_order_row.line_amount, name: @sales_order_row.name, order_quantity: @sales_order_row.order_quantity, row_number: @sales_order_row.row_number, unit_cost: @sales_order_row.unit_cost, unit_price: @sales_order_row.unit_price }
    end

    assert_redirected_to sales_order_row_path(assigns(:sales_order_row))
  end

  test "should show sales_order_row" do
    get :show, id: @sales_order_row
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sales_order_row
    assert_response :success
  end

  test "should update sales_order_row" do
    put :update, id: @sales_order_row, sales_order_row: { discount_amount: @sales_order_row.discount_amount, discount_percent: @sales_order_row.discount_percent, line_amount: @sales_order_row.line_amount, name: @sales_order_row.name, order_quantity: @sales_order_row.order_quantity, row_number: @sales_order_row.row_number, unit_cost: @sales_order_row.unit_cost, unit_price: @sales_order_row.unit_price }
    assert_redirected_to sales_order_row_path(assigns(:sales_order_row))
  end

  test "should destroy sales_order_row" do
    assert_difference('SalesOrderRow.count', -1) do
      delete :destroy, id: @sales_order_row
    end

    assert_redirected_to sales_order_rows_path
  end
end
