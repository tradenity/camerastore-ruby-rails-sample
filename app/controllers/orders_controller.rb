class OrdersController < ApplicationController

  before_action :ensure_authenticated

  def index
    @orders = Order.find_all_by_customer(session[:customer_id])
  end

  def checkout
    customer = Customer.find_by_id session[:customer_id]
    @order = Order.new(customer: customer, billingAddress: create_address, shippingAddress: create_address)
  end

  def create
    customer = Customer.new
    customer.id = session[:customer_id]
    order = Order.new(customer: customer,
                      billingAddress: Address.new(params[:billingAddress]),
                      shippingAddress: Address.new(params[:shippingAddress]))
    transaction = order.checkout(params[:token])
    redirect_to("/orders/#{transaction.order.id}")
  end

  def show
    @order = Order.find_by_id(params[:id])
  end

  def refund
    transaction = Order.refund(params[:id])
    redirect_to("/orders/#{transaction.order.id}")
  end

  def create_address
    Address.new(streetLine1: "3290 Hermosillo Place", streetLine2: "", city: "Washington", state: "Washington, DC", zipCode: "20521-3290", country: "USA")
  end

private
  def ensure_authenticated
    unless logged_in?
      session[:target_url] = request.path
      redirect_to login_path
    end
  end
end