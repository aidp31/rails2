class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]
  protect_from_forgery with: :null_session

  def index
    products = Product.all
    render json: { data: products }
  end

  def show
    render json: @product
  end

  def create
    product = Product.new(product_params)

    if verified_request? && product.save
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def update
    if verified_request? && @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end
end