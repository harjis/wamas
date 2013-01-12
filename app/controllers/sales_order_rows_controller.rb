class SalesOrderRowsController < ApplicationController
  # GET /sales_order_rows
  # GET /sales_order_rows.json
  def index
    @sales_order_rows = SalesOrderRow.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sales_order_rows }
    end
  end

  # GET /sales_order_rows/1
  # GET /sales_order_rows/1.json
  def show
    @sales_order_row = SalesOrderRow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sales_order_row }
    end
  end

  # GET /sales_order_rows/new
  # GET /sales_order_rows/new.json
  def new
    @sales_order_row = SalesOrderRow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sales_order_row }
    end
  end

  # GET /sales_order_rows/1/edit
  def edit
    @sales_order_row = SalesOrderRow.find(params[:id])
  end

  # POST /sales_order_rows
  # POST /sales_order_rows.json
  def create
    @sales_order_row = SalesOrderRow.new(params[:sales_order_row])

    respond_to do |format|
      if @sales_order_row.save
        format.html { redirect_to @sales_order_row, notice: 'Sales order row was successfully created.' }
        format.json { render json: @sales_order_row, status: :created, location: @sales_order_row }
      else
        format.html { render action: "new" }
        format.json { render json: @sales_order_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sales_order_rows/1
  # PUT /sales_order_rows/1.json
  def update
    @sales_order_row = SalesOrderRow.find(params[:id])

    respond_to do |format|
      if @sales_order_row.update_attributes(params[:sales_order_row])
        format.html { redirect_to @sales_order_row, notice: 'Sales order row was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sales_order_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_order_rows/1
  # DELETE /sales_order_rows/1.json
  def destroy
    @sales_order_row = SalesOrderRow.find(params[:id])
    @sales_order_row.destroy

    respond_to do |format|
      format.html { redirect_to sales_order_rows_url }
      format.json { head :no_content }
    end
  end
end
