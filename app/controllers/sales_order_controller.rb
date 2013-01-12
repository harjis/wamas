class SalesOrderController < ApplicationController
  def index
    @sales_orders = SalesOrder.all

    respond_to do |format|
      format.html
      format.json{ render json: @sales_orders}
    end
  end
end
