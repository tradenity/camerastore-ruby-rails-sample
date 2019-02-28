class OrdersController < ApplicationController

  before_action :ensure_authenticated

  def index
    @orders = Order.find_all_by(customer: session[:customer_id])
  end

  def checkout
    usa = Country.find_one_by(iso2: "US")
    customer = Customer.find_by_id session[:customer_id]
    @countries = Country.find_all_by(size: 250, sort: "name")
    @states = State.find_all_by(country: usa.id, size: 60, sort: "name")
    @cart = ShoppingCart.get
    @order = Order.new(customer: customer, billingAddress: create_address(usa), shippingAddress: create_address(usa))
    @stripe_pub_key = STRIPE_PUBLIC_KEY
  end

  def create
    customer = Customer.new
    customer.id = session[:customer_id]
    order = Order.new(customer: customer,
                      billing_address: populate_address(params[:billing_address]),
                      shipping_address: populate_address(params[:shipping_address]))
    begin
      order.create
      session[:order_id] = order.id
      @shipping_methods = ShippingMethod.find_all_for_order(order.id)
      render "shipping_form", layout: false
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end

  def add_shipping
    order = Order.find_by_id session[:order_id]
    order.shipping_method = ShippingMethod.new(id: params[:shipping_method])
    order.update
    render "payment_form", layout: false
  end

  def add_payment
    order = Order.find_by_id session[:order_id]
    payment_source = PaymentToken.new(token: params[:token], customer: Customer.new(id: session[:customer_id]), status: "new").create
    CreditCardPayment.new(order: order, payment_source: payment_source).create
    redirect_to("/orders/#{order.id}")
  end

  def show
    @order = Order.find_by_id(params[:id])
  end

  def refund
    transaction = Order.refund(params[:id])
    redirect_to("/orders/#{transaction.order.id}")
  end

private
  def create_address(us)
    Address.new(street_line1: "3290 Hermosillo Place", street_line2: "", city: "Washington", state: State.new, zip_code: "20521-3290", country: us)
  end

  def populate_address(params)
    Address.new(street_line1: params[:street_line1],
                street_line2: params[:street_line2],
                city: params[:city],
                state: State.new('id' => params[:state]),
                zip_code: params[:zip_code],
                country: Country.new('id' => params[:country]))
  end

  def ensure_authenticated
    unless logged_in?
      session[:target_url] = request.path
      redirect_to login_path
    end
  end
end