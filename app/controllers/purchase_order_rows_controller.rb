class PurchaseOrderRowsController < ApplicationController
  # GET /purchase_order_rows
  # GET /purchase_order_rows.json
  def index
    @purchase_order_rows = PurchaseOrderRow.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchase_order_rows }
    end
  end

  # GET /purchase_order_rows/1
  # GET /purchase_order_rows/1.json
  def show
    @purchase_order_row = PurchaseOrderRow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase_order_row }
    end
  end

  # GET /purchase_order_rows/new
  # GET /purchase_order_rows/new.json
  def new
    @purchase_order_row = PurchaseOrderRow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase_order_row }
    end
  end

  # GET /purchase_order_rows/1/edit
  def edit
    @purchase_order_row = PurchaseOrderRow.find(params[:id])
  end

  # POST /purchase_order_rows
  # POST /purchase_order_rows.json
  def create
    @purchase_order_row = PurchaseOrderRow.new(params[:purchase_order_row])

    respond_to do |format|
      if @purchase_order_row.save
        format.html { redirect_to @purchase_order_row, notice: 'Purchase order row was successfully created.' }
        format.json { render json: @purchase_order_row, status: :created, location: @purchase_order_row }
      else
        format.html { render action: "new" }
        format.json { render json: @purchase_order_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /purchase_order_rows/1
  # PUT /purchase_order_rows/1.json
  def update
    @purchase_order_row = PurchaseOrderRow.find(params[:id])

    respond_to do |format|
      if @purchase_order_row.update_attributes(params[:purchase_order_row])
        format.html { redirect_to @purchase_order_row, notice: 'Purchase order row was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @purchase_order_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_order_rows/1
  # DELETE /purchase_order_rows/1.json
  def destroy
    @purchase_order_row = PurchaseOrderRow.find(params[:id])
    @purchase_order_row.destroy

    respond_to do |format|
      format.html { redirect_to purchase_order_rows_url }
      format.json { head :no_content }
    end
  end
end
