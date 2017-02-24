class Admin::UsersController < Admin::AdminApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_url @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_url @user
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: 'ユーザを削除しました'
  end

  private

  def set_user
    @user = User.find(params[:id])
    @address = @user.address
    unless @address
      @address = @user.build_address
    end
  end

  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, address_attributes: [:zip_code, :prefectures, :city, :address, :address2,:id])
  end
end
