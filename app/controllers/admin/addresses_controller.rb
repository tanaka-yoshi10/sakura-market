class Admin::AddressesController < Admin::AdminApplicationController
  before_action :set_address, only: [:edit, :update]

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to admin_users_url
    else
      render :edit
    end
  end

  private

    def set_address
      @user = User.find(params[:user_id])
      @address = @user.address
      unless @address
        @address = Address.new
      end
    end

    def address_params
      params.require(:address).permit(:zip_code, :prefectures, :city, :address, :address2)
    end
end
