class GasPricesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to new_car_path if (current_user.car == nil)
  end

  def index
    city_id = current_user.city_id
    gas_grade_id = current_user.car.gas_grade_id
    @user_city = current_user.city.name
    @grade_name = current_user.car.gas_grade.grade_name
    # abbreviation of gas_change_percentage_prediction, current_gas_price
    @gcpp, @cgp = predict_gas_change(city_id, gas_grade_id)
    # to get the predition gas price
    @pgp = @cgp * (1.0 + @gcpp)
  end

# to get daily oil price
  def get_oil_price_obj(date)
    oil_price_obj = OilPrice.where('date <= ?', date).order(date: :desc).limit(1)[0]
    if oil_price_obj == nil
      oil_price_obj = OilPrice.order(date: :asc).limit(1)[0]
    end
    return oil_price_obj
  end

# to get daily oil change percentage
  def get_oil_change_percentage(cur_date, change_days)
    cur_oil_price_obj = get_oil_price_obj(cur_date)
    prev_oil_price_obj = get_oil_price_obj(cur_date + change_days)
    if cur_oil_price_obj == nil || prev_oil_price_obj == nil
      cur_oil_price = 0.0
      prev_oil_price = 0.0
    else
      cur_oil_price = cur_oil_price_obj.oil_price.to_f
      prev_oil_price = prev_oil_price_obj.oil_price.to_f
    end
    return (cur_oil_price - prev_oil_price) / prev_oil_price
  end

# to get daily gas price, if you can find that date, it will be the oldest date by default
  def get_gas_price_obj(date, city_id, gas_grade_id)
    gas_price_obj = GasPrice.where('date <= ? and city_id = ? and gas_grade_id = ?',
        date, city_id, gas_grade_id).order(date: :desc).limit(1)[0]
    if gas_price_obj == nil
      gas_price_obj = GasPrice.where('city_id = ? and gas_grade_id = ?',
          city_id, gas_grade_id).order(date: :asc).limit(1)[0]
    end
    return gas_price_obj
  end

 # to get daily gas change percentage
  def get_gas_change_percentage(cur_date, change_days, city_id, gas_grade_id)
    cur_gas_price_obj = get_gas_price_obj(cur_date, city_id, gas_grade_id)
    prev_gas_price_obj = get_gas_price_obj(cur_date + change_days, city_id, gas_grade_id)
    if cur_gas_price_obj == nil || prev_gas_price_obj == nil
      cur_gas_price = 0.0
      prev_gas_price = 0.0
    else
      cur_gas_price = cur_gas_price_obj.gas_price.to_f
      prev_gas_price = prev_gas_price_obj.gas_price.to_f
    end
    return (cur_gas_price - prev_gas_price) / prev_gas_price
  end

# to get the predition method, set x days back of the changes
  def predict_gas_change(city_id, gas_grade_id)
    change_days = -7
    oil_change_percentage = get_oil_change_percentage(Date.today, change_days)
    gas_change_percentage = get_gas_change_percentage(Date.today, change_days, city_id, gas_grade_id)
    if oil_change_percentage > gas_change_percentage
      # when oil prices go up, gas prices quickly follow
      multiplier = 1.5
    else
      # when oil prices go down, gas prices follow more slowly
      multiplier = 0.5
    end
    puts "oil change percentage = #{oil_change_percentage}"
    puts "gas change percentage = #{gas_change_percentage}"
    delta = (oil_change_percentage - gas_change_percentage) * multiplier
    gas_change_percentage_prediction = (gas_change_percentage + delta) / change_days.to_f.abs
    current_gas_price_obj = get_gas_price_obj(Date.today, city_id, gas_grade_id)
    if current_gas_price_obj == nil
      current_gas_price = 0.0
    else
      current_gas_price = current_gas_price_obj.gas_price
    end

    return gas_change_percentage_prediction, current_gas_price
  end

# since the data is pulled from intenet,these follwing function wont be used
  # def edit
  # end

  # def create
  #   @gas_price = GasPrice.new(gas_price_params)

  #   respond_to do |format|
  #     if @gas_price.save
  #       format.html { redirect_to @gas_price, notice: 'Gas price was successfully created.' }
  #       format.json { render :show, status: :created, location: @gas_price }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @gas_price.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def update
  #   respond_to do |format|
  #     if @gas_price.update(gas_price_params)
  #       format.html { redirect_to @gas_price, notice: 'Gas price was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @gas_price }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @gas_price.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end


  # def destroy
  #   @gas_price.destroy
  #   respond_to do |format|
  #     format.html { redirect_to gas_prices_url, notice: 'Gas price was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private

  #   def set_gas_price
  #     @gas_price = GasPrice.find(params[:id])
  #   end

  #   def gas_price_params
  #     params.require(:gas_price).permit(:daily_price, :gas_type)
  #   end
end
