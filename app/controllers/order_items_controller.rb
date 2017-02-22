class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:update, :destroy]

  def create
    @order_item = current_order.order_items.find_or_initialize_by(product_id: order_item_params[:product_id])
    if @order_item.new_record?
      @order_item.update!(order_item_params)
    else
      @order_item.quantity = @order_item.quantity + order_item_params[:quantity].to_i
      @order_item.save!
    end
  end

  def update
    @order_item.update!(order_item_params)
  end

  def destroy
    @order_item.destroy!
  end

  private

  def set_order_item
    @order_item = current_order.order_items.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
