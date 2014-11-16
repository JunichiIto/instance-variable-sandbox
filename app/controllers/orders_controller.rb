class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :new_csv, :import_csv]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_csv
  end

  def import_csv
    @order.read_csv(params[:file])
    @order.save_details
    @result = @order.result
    respond_to do |format|
      if @result.all?{|r| r == true }
        format.html { redirect_to @order, notice: 'CSV was successfully imported.' }
      else
        format.html { render :new_csv }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      id = params[:order_id] || params[:id]
      @order = Order.find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(
          :name, :address,
          order_details_attributes: %i(id item_name unit_price quantity _destroy)
      )
    end
end
