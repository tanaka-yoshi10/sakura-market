class Admin::ProductsController < Admin::AdminApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.where({:display_flag => true }).order('display_order ASC')
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_url @product, notice: '商品の登録が完了しました'
    else
      render :new, alert: '商品の登録に失敗しました'
    end
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_url @product, notice: '商品の更新が完了しました'
    else
      render :edit, alert: '商品の更新に失敗しました'
    end
  end

  def destroy
    if @product.destroy
      redirect_to admin_products_url, notice: '商品の削除が完了しました'
    else
      render :show, alert: '商品の削除に失敗しました'
    end

  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :display_flag, :display_order, :image)
    end
end
