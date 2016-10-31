class AccountsController < ApplicationController

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    @customer.create
    redirect_to login_url
  end
end