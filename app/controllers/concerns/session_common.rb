module SessionCommon
  extend ActiveSupport::Concern

  def authenticate(admin=false)
    if inner_authenticate(admin)
      reset_user_session
      session[:user_id] = @user.id
      @user.id
    else
      @user = User.new
      flash.now[:referer] = params[:referer]
      #flash.now[:error] = true
      nil
    end
  end

  private

  def inner_authenticate(admin=false)
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      if admin
        if @user.admin_flag?
          true
        else
          false
        end
      else
        true
      end
    else
      false
    end
  end
end