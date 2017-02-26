class RegistrationsController < ApplicationController

  skip_before_action :user_logged_in?

  def new
    @user = User.new
  end

  def create
    if User.create(sign_up_params)
      reset_user_session
      redirect_to session_url
    else
      render :new
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
