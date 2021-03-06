class ProfilesController < ApplicationController
  before_action :set_address, only: [:show, :edit_address, :update_address]

  # REVIEW AddressesControllerは管理者専用としたので、自分の住所変更はここに組み込み
  # REVIEW プロフィール変更とパスワード変更を別画面としたのでcontrollerのメソッドも別にしている

  def show
  end

  def edit_profile
  end

  def edit_address
    # REVIEW 呼出元画面（caller）によって遷移先を変える
    @caller = params[:caller]
  end

  def edit_password
  end

  def update_profile
    if @current_user.update_profile_only(profile_params)
      redirect_to profiles_url
    else
      render :edit_profile
    end
  end

  def update_address
    if @address.update(address_params)
      # REVIEW 呼出元画面（caller）によって遷移先を変える
      caller = params[:caller]
      if caller == 'cart'
        redirect_to cart_url
      else
        redirect_to profiles_url
      end
    else
      render :edit_address
    end
  end

  def update_password
    if @current_user.update_attributes(password_params)
      redirect_to profiles_url
    else
      render :edit_password
    end
  end

  private

  def set_address
    @address = @current_user.address
    unless @address
      @address = @current_user.build_address
    end
  end

  def profile_params
    params.require(:user).permit(:id, :name, :email)
  end

  def password_params
    params.require(:user).permit(:id, :password, :password_confirmation)
  end

  def address_params
    params.require(:address).permit(:zip_code, :prefectures, :city, :address, :address2)
  end
end
