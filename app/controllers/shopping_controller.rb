class ShoppingController < ApplicationController
  PER_PAGE_NUM = 6

  before_action :set_new_item, only: [:index, :show]
  helper_method :sort_column, :sort_direction

  def index
    @products = Product.where({:display_flag => true }).order(sort_column + ' ' + sort_direction).page(params[:page]).per(PER_PAGE_NUM)
  end

  # [review] これはProductsControllerを作って、Product#showにしたいです
  def show
    @product = Product.find(params[:id])
  end

  private

  def set_new_item
    # set_new_itemだったら インスタンス変数名は@new_itemとかになってて欲しいです
    @order_item = current_order.order_items.new
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "display_order"
  end
end
