class CartController < ApplicationController

  def index
  end

  def create
    cart = ShoppingCart.add(LineItem.new(product: Product.new(id: params[:product]), quantity: params[:quantity]))

    respond_to do |format|
      msg = { total: cart.total, count: cart.count }
      format.json  { render :json => msg }
    end
  end

  def delete
    cart = ShoppingCart.remove(params[:id])
    respond_to do |format|
      msg = { total: cart.total, count: cart.count }
      format.json  { render :json => msg }
    end
  end

end