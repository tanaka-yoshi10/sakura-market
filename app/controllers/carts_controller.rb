class CartsController < ApplicationController

  # REVIEW カートと注文履歴を別Controllerとしているが、一緒でもよいか？（viewは分けたい）
  # [review] → 別が良いと思います(そのほうが責任分担がわかりやすいと思います)
  # これが理想というわけでは無いですが、以下参考になる記事のURLです。
  # http://postd.cc/how-dhh-organizes-his-rails-controllers/

  def show
    @order = current_order
  end

  # 注文確定
  def update
    if current_order.confirm
      redirect_to cart_path, notice: '注文を確定しました'
    else
      flash.now[:alert] = '注文の確定に失敗しました'
      render :show
    end
  end

end
