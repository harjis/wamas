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
        @warehouse_entry.quantity = shipment_row.shipped_quantity
        #TODO: figure out if we want to keep track on entry.remaining quantity and entry.unit_cost
        @warehouse_entry.remaining_quantity = 0
        @warehouse_entry.unit_cost = 0
        @warehouse_entry.product_id = shipment_row.sales_order_row.product.id
        @warehouse_entry.entry_type = 'shipment'

        if @warehouse_entry.save
          shipment_row.warehouse_entry_id = @warehouse_entry.id
          shipment_row.total_amount = shipment_row.shipped_quantity * shipment_row.unit_price;

          @old_warehouse_entry_spot = WarehouseEntrySpot.find(params[:warehouse_entry_spots][i.to_s][:warehouse_entry_spot])
          @new_warehouse_entry_spot = WarehouseEntrySpot.new
          @new_warehouse_entry_spot.warehouse_entry_id = @warehouse_entry.id
          @new_warehouse_entry_spot.warehouse_spot_id = @old_warehouse_entry_spot.warehouse_spot_id;

        end
      end
    end

    respond_to do |format|
      @supply.supply_rows.each_with_index do |supply_row, i|
        @warehouse_entry = WarehouseEntry.new
        @warehouse_entry.quantity = supply_row.supplied_quantity
        @warehouse_entry.remaining_quantity = supply_row.supplied_quantity
        @warehouse_entry.unit_cost = supply_row.unit_cost
        @warehouse_entry.product_id = supply_row.purchase_order_row.product.id
        @warehouse_entry.entry_type = 'supply'

        if @warehouse_entry.save
          supply_row.warehouse_entry_id = @warehouse_entry.id
          supply_row.total_amount = supply_row.supplied_quantity * supply_row.unit_cost

          @warehouse_entry_spot = WarehouseEntrySpot.new
          @warehouse_entry_spot.warehouse_entry_id = @warehouse_entry.id
          @warehouse_entry_spot.warehouse_spot_id = params[:warehouse_spots][i.to_s][:warehouse_spot]
          @warehouse_entry_spot.spot_quantity = supply_row.supplied_quantity
          @warehouse_entry_spot.remaining_spot_quantity = supply_row.supplied_quantity

          if @warehouse_entry_spot.save
            if @supply.save
              format.html { redirect_to @supply, notice: 'Supply was successfully updated.' }
              format.json { head :no_content }
            else
              format.html { render "purchase_order/show_receive/#{params[:purchase_order]}" }
              format.json { render json: @supply.errors, status: :unprocessable_entity }
            end
          else
            # error
          end

        else
          #error
        end
      end
    end
  end
end
