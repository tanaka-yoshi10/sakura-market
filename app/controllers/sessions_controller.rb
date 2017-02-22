class SessionsController < ApplicationController
  include SessionCommon

  skip_before_action :user_logged_in?

  def show
    @user = User.new
  end

  def create
    @userId = authenticate
    if @userId
      redirect_to params[:referer].present? ? params[:referer] : root_path
    else
      flash.now[:alert] = 'ユーザー名またはパスワードが違います'
      render :show
    end
  end

  def delete
    reset_user_session
    redirect_to session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
