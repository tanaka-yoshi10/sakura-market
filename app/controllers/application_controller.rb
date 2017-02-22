class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  before_action :user_logged_in?

  def reset_user_session
    session.clear
    @current_user = nil
  end

  def user_logged_in?
    user_id = session[:user_id]
    if user_id then
      begin
        @current_user = User.find(user_id)
      rescue ActiveRecord::RecordNotFound
        reset_user_session
      end
    end

    unless @current_user
      flash[:referer] = request.fullpath
      redirect_to session_url
    end
  end

  def current_order
    @order = @current_user.orders.with_status(:on_cart).first
    if @order.nil?
      @order = @current_user.orders.create
    end
    @order
  end

  class Forbidden < ActionController::ActionControllerError; end

  rescue_from Exception, with: :rescue500 unless Rails.env.development?
  rescue_from ActionController::RoutingError, with: :rescue404 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404 unless Rails.env.development?
  rescue_from Forbidden, with: :rescue403

  def rescue500(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    if request.xhr?
      render json: { error: '500 error' }, status: 500
    else
      render template: 'errors/internal_error', status: 500, layout: 'application', content_type: 'text/html'
    end
  end

  def rescue404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    if request.xhr?
      render json: { error: '404 error' }, status: 404
    else
      render template: 'errors/not_found', status: 404, layout: 'application', content_type: 'text/html'
    end
  end

  def rescue403(exception = nil)
    logger.info "Rendering 403 with exception: #{exception.message}" if exception
    if request.xhr?
      render json: { error: '403 error' }, status: 403
    else
      render template: 'errors/forbidden', status: 403, layout: 'application', content_type: 'text/html'
    end
  end
end
