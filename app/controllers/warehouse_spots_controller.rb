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

  # GET /warehouse_spots/all_by_warehouse_id/1
  # GET /warehouse_spots/all_by_warehouse_id/1.json
  def all_by_warehouse_id
    @warehouse_spots = WarehouseSpot.find_all_by_warehouse_id(params[:warehouse_id])

    respond_to do |format|
      format.json { render json: @warehouse_spots }
    end
  end

  # GET /warehouse_spots/spots_with_balance_by_warehouse_id_sales_order_row_id.json
  def spots_with_balance
    @sales_order_row = SalesOrderRow.joins(:product).find(params[:sales_order_row_id])

    #two different ways. first one is lazy load, second one is eager

    #@warehouse_spots = WarehouseSpot.includes(:warehouse_entry_spots => [{:warehouse_entry => :product}])
    #.where(:warehouse_id => params[:warehouse_id])
    #.where('warehouse_entries.product_id = ?', @sales_order_row.product)
    #.where('warehouse_entry_spots.remaining_spot_quantity > 0')

    @warehouse_spots = WarehouseSpot.joins(:warehouse_entry_spots => [{:warehouse_entries => :product}])
    .where(:warehouse_id => params[:warehouse_id])
    .where('warehouse_entries.product_id = ?', @sales_order_row.product)
    .where('warehouse_entry_spots.remaining_spot_quantity > 0')
    .group('warehouse_spots.id')

    respond_to do |format|
      #format.json { render json: @warehouse_spots }
      format.json { render json: @warehouse_spots.to_json(:include => :warehouse_entry_spots) }
    end
  end

  # GET /warehouse_spots/1/content/1.json
  def content
    @warehouse_spot = WarehouseSpot.joins(:warehouse_entry_spots => [{:warehouse_entries => :product}])
    .where(:id => params[:warehouse_spot_id])
    .where(:warehouse_id => params[:warehouse_id])

    respond_to do |format|
      format.json { render json: @warehouse_spot.to_json(
          :include => {
              :warehouse_entry_spots => {
                  :include =>{
                      :warehouse_entries => {
                          :include => :product
                      }
                  }
              }
          }
      ) }
      #format.json { render json: @warehouse_spot.to_json(:include => [{:warehouse_entry_spots => [{:include => [:warehouse_entries] }] }] )}
    end
  end
end
