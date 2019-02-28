class CartController < ApplicationController

  def index
  end

  def create
    cart = ShoppingCart.add_item(LineItem.new(product: Product.new(id: params[:product]), quantity: params[:quantity]))

    respond_to do |format|
      msg = { total: cart.total, count: cart.items.size }
      format.json  { render :json => msg }
    end
  end

  def delete
    cart = ShoppingCart.delete_item(params[:id])
    respond_to do |format|
      msg = { total: cart.total, count: cart.items.size }
      format.json  { render :json => msg }
    end
  end

end