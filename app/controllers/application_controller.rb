class ApplicationController < ActionController::Base


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :load_common_models

  rescue_from 'Tradenity::SessionExpiredException' , with: :handle_session_expiry


  def load_common_models
    @categories = Category.find_all
    @cart = ShoppingCart.get
  end

  def current_customer
    @_current_customer ||= session[:customer_id] && Customer.find_by_id(session[:customer_id])
  end

  def logged_in?
    current_customer != nil
  end

private
  def handle_session_expiry(exception)
    Tradenity.reset_current_session
    redirect_to home_path
  end
end
