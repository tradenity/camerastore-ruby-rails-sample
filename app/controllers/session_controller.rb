class SessionController < ApplicationController

  def new
  end

  def create
    customer = Customer.find_one_by(username: params[:username])
    if customer != nil && valid_password?(customer.password, params[:password])
      session[:customer_id] = customer.id
      if session.has_key? :target_url
        target_url = session[:target_url]
        session.delete(:target_url)
      else
        target_url = '/'
      end
      redirect_to target_url, notice: 'Logged in successfully!'
    else
      redirect_to action: :new, flash: 'Invalid credentials'
    end
  end

  def destroy
    session.delete(:customer_id)
    redirect_to '/'
  end

end