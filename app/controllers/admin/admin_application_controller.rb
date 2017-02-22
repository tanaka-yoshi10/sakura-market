class Admin::AdminApplicationController < ApplicationController

  def user_logged_in?
    super

    # 管理者でなかった場合はログイン画面にリダイレクト
    unless @current_user.admin_flag
      flash[:referer] = request.fullpath
      redirect_to admin_admins_url
    end
  end

end
