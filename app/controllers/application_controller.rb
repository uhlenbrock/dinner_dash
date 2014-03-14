class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    helper_method :current_cart, :current_user, :is_admin?, :user_signed_in?

    def current_cart
      @current_cart ||= Cart.new(session)
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authorized?
      redirect_to root_path, alert: 'Not authorized!' unless user_signed_in?
    end

    def authorized_for_admin?
      redirect_to root_path, alert: 'Not authorized!' unless is_admin?
    end

    def authorized_for_self?
      redirect_to root_path, alert: 'Not authorized!' unless user_signed_in? && (current_user.id.to_s == params[:id])
    end

    def is_admin?
      user_signed_in? && current_user.admin?
    end

    def user_signed_in?
      !current_user.nil?
    end

end
