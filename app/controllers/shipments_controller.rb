class ShipmentsController < ApplicationController
  # GET /shipments
  # GET /shipments.json
  def index
    @shipments = Shipment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shipments }
    end
  end

  # GET /shipments/1
  # GET /shipments/1.json
  def show
    @shipment = Shipment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shipment }
    end
  end

  # GET /shipments/new
  # GET /shipments/new.json
  def new
    @shipment = Shipment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shipment }
    end
  end

  # GET /shipments/1/edit
  def edit
    @shipment = Shipment.find(params[:id])
  end

  # POST /shipments
  # POST /shipments.json
  def create
    @shipment = Shipment.new(params[:shipment])

    respond_to do |format|
      if @shipment.save
        format.html { redirect_to @shipment, notice: 'Shipment was successfully created.' }
        format.json { render json: @shipment, status: :created, location: @shipment }
      else
        format.html { render action: "new" }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shipments/1
  # PUT /shipments/1.json
  def update
    @shipment = Shipment.find(params[:id])

    respond_to do |format|
      if @shipment.update_attributes(params[:shipment])
        format.html { redirect_to @shipment, notice: 'Shipment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipments/1
  # DELETE /shipments/1.json
  def destroy
    @shipment = Shipment.find(params[:id])
    @shipment.destroy

    respond_to do |format|
      format.html { redirect_to shipments_url }
      format.json { head :no_content }
    end
  end

  # POST /shipments/deliver/1
  # POST /shipments/deliver/1.json
  def deliver
    @shipment = Shipment.new(params[:shipment])
    @shipment.warehouse = Warehouse.find(params[:warehouse][:warehouse_id])

    respond_to do |format|
      @shipment.shipment_rows.each_with_index do |shipment_row, i|
        @warehouse_entry = WarehouseEntry.new
        @warehouse_entry.populate_by_shipment_or_supply(shipment_row)

        if @warehouse_entry.save
          shipment_row.warehouse_entry_id = @warehouse_entry.id

          @warehouse_entry_spot = WarehouseEntrySpot.find(params[:warehouse_entry_spots][i.to_s][:warehouse_entry_spot])
          @warehouse_entry_spot.remaining_spot_quantity -= shipment_row.shipped_quantity
          @warehouse_entry_spot.warehouse_entries << @warehouse_entry

          if @warehouse_entry_spot.save
            if @shipment.save
              @shipment.sales_order = SalesOrder.find(params[:sales_order][:sales_order_id])
              format.html { redirect_to @shipment, notice: 'Shipment was successfully updated.' }
              format.json { head :no_content }
            else
              format.html { render "sales_orders/show_delivery/#{params[:sales_order]}" }
              format.json { render json: @shipment.errors, status: :unprocessable_entity }
            end
          else
            #error
          end
        else
          #error
        end
      end
    end
  end
end
