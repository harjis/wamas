class WarehouseInventoriesController < ApplicationController
  autocomplete :product, :name, :full => true
  # GET /warehouse_inventories
  # GET /warehouse_inventories.json
  def index
    @warehouse_inventories = WarehouseInventory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @warehouse_inventories }
    end
  end

  # GET /warehouse_inventories/1
  # GET /warehouse_inventories/1.json
  def show
    @warehouse_inventory = WarehouseInventory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @warehouse_inventory }
    end
  end

  # GET /warehouse_inventories/new
  # GET /warehouse_inventories/new.json
  def new
    @warehouse_inventory = WarehouseInventory.new
    @warehouse_inventory.warehouse_inventory_rows.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @warehouse_inventory }
    end
  end

  # GET /warehouse_inventories/1/edit
  def edit
    @warehouse_inventory = WarehouseInventory.find(params[:id])
  end

  # POST /warehouse_inventories
  # POST /warehouse_inventories.json
  def create
    @warehouse_inventory = WarehouseInventory.new(params[:warehouse_inventory])
    @warehouse_inventory.warehouse = Warehouse.find(params[:warehouse_inventory][:warehouse_id]);

    @warehouse_inventory.warehouse_inventory_rows.each_with_index do |inventory_row, i|
      @warehouse_entry = WarehouseEntry.new
      @warehouse_entry.populate_by_inventory(inventory_row)

      if @warehouse_entry.save
        inventory_row.warehouse_entry = @warehouse_entry

        @warehouse_entry_spot = WarehouseEntrySpot.find(params[:warehouse_inventory][i.to_s][:warehouse_entry_spot_id])
        @warehouse_entry_spot.remaining_spot_quantity = inventory_row.counted_quantity
        @warehouse_entry_spot.warehouse_entries << @warehouse_entry

        if @warehouse_entry_spot.save
          if @warehouse_inventory.save
            respond_to do |format|
              format.html { redirect_to @warehouse_inventory, notice: 'Warehouse inventory was successfully created.' }
              format.json { render json: @warehouse_inventory, status: :created, location: @warehouse_inventory }
            end
          end
        else
          format.html { render action: "new" }
          format.json { render json: @warehouse_inventory.errors, status: :unprocessable_entity }
        end
      else
        #error
      end
    end

    #respond_to do |format|
    #  if @warehouse_inventory.save
    #    format.html { redirect_to @warehouse_inventory, notice: 'Warehouse inventory was successfully created.' }
    #    format.json { render json: @warehouse_inventory, status: :created, location: @warehouse_inventory }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @warehouse_inventory.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PUT /warehouse_inventories/1
  # PUT /warehouse_inventories/1.json
  def update
    @warehouse_inventory = WarehouseInventory.find(params[:id])

    respond_to do |format|
      if @warehouse_inventory.update_attributes(params[:warehouse_inventory])
        format.html { redirect_to @warehouse_inventory, notice: 'Warehouse inventory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @warehouse_inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouse_inventories/1
  # DELETE /warehouse_inventories/1.json
  def destroy
    @warehouse_inventory = WarehouseInventory.find(params[:id])
    @warehouse_inventory.destroy

    respond_to do |format|
      format.html { redirect_to warehouse_inventories_url }
      format.json { head :no_content }
    end
  end
end
