class Admin::AdminsController < Admin::AdminApplicationController
  include SessionCommon

  skip_before_action :user_logged_in?

  def show
    @user = User.new
    render :layout => 'sessions'
  end

  def create
    @userId = authenticate(admin=true)
    if @userId
      redirect_to admin_users_url
    else
      render :show, :layout => 'sessions'
    end
  end

  def delete
    reset_user_session
    redirect_to admin_admins_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
