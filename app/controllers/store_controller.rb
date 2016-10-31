class StoreController < ApplicationController


  def index
    @collections = Collection.find_all
    @cart = ShoppingCart.get
  end

  def products
    if params[:query].present?
      @products =  Product.find_all(title: params[:query])
    else
      @products =  Product.find_all
    end
    @brands =  Brand.find_all
    @featured =  Collection.find_one(name: 'featured')
    render 'products', layout: 'products'
  end

  def categories
    @brands =  Brand.find_all
    @categories =  Category.find_all
    @products =  Product.find_all(category: params[:id])
    @featured =  Collection.find_one(name: 'featured')

    render 'products', layout: 'products'
  end

  def brands
    @brands =  Brand.find_all
    @products =  Product.find_all(brand: params[:id])
    @featured =  Collection.find_one(name: 'featured')

    render 'products', layout: 'products'
  end

  def product_details
    @brands =  Brand.find_all
    @product =  Product.find_by_id(params[:id])
    @featured =  Collection.find_one(name: 'featured')

    render 'single', layout: 'products'
  end

end

