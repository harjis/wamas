class SuppliesController < ApplicationController
  # GET /supplies
  # GET /supplies.json
  def index
    @supplies = Supply.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @supplies }
    end
  end

  # GET /supplies/1
  # GET /supplies/1.json
  def show
    @supply = Supply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @supply }
    end
  end

  # GET /supplies/new
  # GET /supplies/new.json
  def new
    @supply = Supply.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supply }
    end
  end

  # GET /supplies/1/edit
  def edit
    @supply = Supply.find(params[:id])
  end

  # POST /supplies
  # POST /supplies.json
  def create
    @supply = Supply.new(params[:supply])

    respond_to do |format|
      if @supply.save
        format.html { redirect_to @supply, notice: 'Supply was successfully created.' }
        format.json { render json: @supply, status: :created, location: @supply }
      else
        format.html { render action: "new" }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /supplies/1
  # PUT /supplies/1.json
  def update
    @supply = Supply.find(params[:id])

    respond_to do |format|
      if @supply.update_attributes(params[:supply])
        format.html { redirect_to @supply, notice: 'Supply was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplies/1
  # DELETE /supplies/1.json
  def destroy
    @supply = Supply.find(params[:id])
    @supply.destroy

    respond_to do |format|
      format.html { redirect_to supplies_url }
      format.json { head :no_content }
    end
  end

  # POST /supplies/receive/1
  # POST /supplies/receive/1.json
  def receive
    @supply = Supply.new(params[:supply])
    @supply.warehouse = Warehouse.find(params[:warehouse][:warehouse_id])

    respond_to do |format|
      if @supply.save
        @supply.purchase_orders << PurchaseOrder.find(params[:purchase_order][:purchase_order_id])
        @supply.supply_rows.each_with_index do |supply_row, i|
          @warehouse_entry = WarehouseEntry.new
          @warehouse_entry.populate_by_shipment_or_supply(supply_row)

          if @warehouse_entry.save
            supply_row.warehouse_entry_id = @warehouse_entry.id
            @supply.save

            if @warehouse_entry.warehouse_entry_spots.create(:warehouse_spot_id => params[:warehouse_spots][i.to_s][:warehouse_spot],
                                                             :spot_quantity => supply_row.supplied_quantity,
                                                             :remaining_spot_quantity => supply_row.supplied_quantity)
              format.html { redirect_to @supply, notice: 'Supply was successfully updated.' }
              format.json { head :no_content }
            else
              format.html { render "purchase_order/show_receive/#{params[:purchase_order]}" }
              format.json { render json: @supply.errors, status: :unprocessable_entity }
            end
          else
            # error
          end
        end
      else
        #error
      end
    end
  end
end
