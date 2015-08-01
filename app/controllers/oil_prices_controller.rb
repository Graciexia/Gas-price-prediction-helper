class OilPricesController < ApplicationController
  before_action :set_oil_price, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter do
    redirect_to new_car_path if (current_user.car == nil)
  end

  # GET /oil_prices
  # GET /oil_prices.json
  def index
    @oil_prices = OilPrice.all
    city_id = current_user.city_id
    gas_grade_id = current_user.car.gas_grade_id
    @gas_prices = GasPrice.where(city_id: city_id, gas_grade_id: gas_grade_id).select('date as "date"', :gas_price)
  end


private

  def oil_price_params
    params.require(:oil_price).permit(:daily_oil_price, :date)
  end
end
