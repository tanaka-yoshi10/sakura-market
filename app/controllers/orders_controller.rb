class OrdersController < ApplicationController

  def index
   @orders = @current_user.orders.all.without_status(:on_cart).order('order_datetime DESC')
   @new_order_item = current_order.order_items.build
  end

  def update
    @order = @current_user.orders.find(params[:id])
    if @order.update(order_params)
      # REVIEW 外部viewを指定している
      render action: '../carts/update_ship_time'
    else
      render status: :internal_server_error
    end
  end

  private
    def order_params
      params.require(:order).permit(:order_datetime, :status, :payment_code, :ship_time_id, :user_id, :ship_date)
    end
end
