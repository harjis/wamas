class WarehouseSpotsController < ApplicationController
  # GET /warehouse_spots
  # GET /warehouse_spots.json
  def index
    @warehouse_spots = WarehouseSpot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @warehouse_spots }
    end
  end

  # GET /warehouse_spots/1
  # GET /warehouse_spots/1.json
  def show
    @warehouse_spot = WarehouseSpot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @warehouse_spot }
    end
  end

  # GET /warehouse_spots/new
  # GET /warehouse_spots/new.json
  def new
    @warehouse_spot = WarehouseSpot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @warehouse_spot }
    end
  end

  # GET /warehouse_spots/1/edit
  def edit
    @warehouse_spot = WarehouseSpot.find(params[:id])
  end

  # POST /warehouse_spots
  # POST /warehouse_spots.json
  def create
    @warehouse_spot = WarehouseSpot.new(params[:warehouse_spot])

    @warehouse_spot.warehouse = Warehouse.find(params[:warehouse][:warehouse_id])

    respond_to do |format|
      if @warehouse_spot.save
        format.html { redirect_to @warehouse_spot, notice: 'Warehouse spot was successfully created.' }
        format.json { render json: @warehouse_spot, status: :created, location: @warehouse_spot }
      else
        format.html { render action: "new" }
        format.json { render json: @warehouse_spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /warehouse_spots/1
  # PUT /warehouse_spots/1.json
  def update
    @warehouse_spot = WarehouseSpot.find(params[:id])

    @warehouse_spot.warehouse = Warehouse.find(params[:warehouse][:warehouse_id])

    respond_to do |format|
      if @warehouse_spot.update_attributes(params[:warehouse_spot])
        format.html { redirect_to @warehouse_spot, notice: 'Warehouse spot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @warehouse_spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouse_spots/1
  # DELETE /warehouse_spots/1.json
  def destroy
    @warehouse_spot = WarehouseSpot.find(params[:id])
    @warehouse_spot.destroy

    respond_to do |format|
      format.html { redirect_to warehouse_spots_url }
      format.json { head :no_content }
    end
  end
end
