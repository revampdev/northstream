class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  def index
    @pagy, @orders = pagy(Order.sort_by_params(params[:sort], sort_direction))

    # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
    # Calling @orders.any? in the view will use the loaded records to check existence instead of making an extra DB call.
    @orders.load
  end

  # GET /orders/1
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
  def create
    @order = Order.new
    @order.account_id = params[:order][:account_id]
    line_items = LineItem.new({name: params[:order][:product_name], amount: params[:order][:amount], quantity: params[:order][:quantity]})
    if @order.save
      domain = current_tenant.domain.empty? ? current_tenant.subdomain : current_tenant.domain
      line_items.order_id = @order.id
      line_items.save
      @checkout = Order.create_session(@order, domain, params[:order][:stream_slug], current_user)
      redirect_to checkout_path({session_id: @checkout.id})
    else
      render stream_path(params[:order][:stream_slug]), status: :unprocessable_entity, alert: "Something went wrong. Please try again."
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Order was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: "Order was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def order_params
    params.require(:order).permit(:account_id, :amount, :product_name, :quantity, :stream_slug)
  end
end
