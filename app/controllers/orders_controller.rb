class OrdersController < ApplicationController

  include ActionView::Helpers::DateHelper

  before_action :set_order, only: [:show, :edit, :update, :destroy, :remove_item, :transition]
  before_action :authorized_for_admin?, only: [:edit, :update, :destroy, :remove_item, :transition]
  before_action :authorized?, only: [:new, :create, :index, :show]

  # GET /orders
  # GET /orders.json
  def index
    if is_admin?
      if !params[:order_status].blank?
        @orders = Order.includes(:user).with_status(params[:order_status])
      else
        @orders = Order.includes(:user).all
      end
    else
      @orders = current_user.orders
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.build(order_params)
    @order.item_ids = current_cart.item_ids
    if @order.save
      current_cart.empty!
      relative_time = distance_of_time_in_words Time.zone.now, @order.pickup_at
      message = "Your order has been created. It will be ready for pickup in #{relative_time}."
      redirect_to order_path(@order), notice: message
    else
      redirect_to cart_path, alert: "Order could not be created: #{@order.errors.full_messages.join(',')}"
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def remove_item
    item = Item.find(params[:item_id])
    @order.items.destroy(item) if item
    redirect_to order_path(@order), alert: 'Item successfully removed.'
  end

  def transition
    if Order.order_statuses.include? params[:order_status]
      message = "Order successfully marked #{params[:order_status]}."
      @order.update_attribute(:order_status, params[:order_status])
    else
      message = "Order could not be updated."
    end
    redirect_to orders_path, alert: message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order].permit!
    end

    def authorized?
      if !user_signed_in?
        session[:return_to] = request.path
        redirect_to signin_path, alert: 'You must sign in before checking out.'
      end
    end
end
