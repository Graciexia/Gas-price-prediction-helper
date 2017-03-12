class CarsController < ApplicationController
  include CarsHelper
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    if current_user.car == nil
      redirect_to new_car_path
    else
      @user_car = current_user.car
      @city_mileage = @user_car.city_mileage
      @highway_mileage = @user_car.highway_mileage
      @comb_mileage = @user_car.comb_mileage
      city_id = current_user.city_id
      gas_grade_id = @user_car.gas_grade_id
      @grade_name = @user_car.gas_grade.grade_name
      @car_name = "#{@user_car.year.to_s} #{@user_car.make} #{@user_car.model} (#{@user_car.trany})"
      date = Date.today
      @user_gas_price = calculate_gas_price(date, city_id, gas_grade_id)
      @sipper_gas_price = calculate_gas_price(date, city_id, find_sipper_gas_grade_id)
      @guzzler_gas_price = calculate_gas_price(date, city_id, find_guzzler_gas_grade_id)
    end
  end

  def show
    @car = current_user.car
    @city_name = current_user.city.name
  end

  def new
    if current_user.car != nil
      redirect_to edit_car_path
    else
      @car = Car.new   # @cost = pramas[:miles]/@comb_mileage * @pgp
      @years = ['Select year...'] + Car.uniq.pluck(:year).sort
      @makes = ['Select make...']
      @models = ['Select model...']
      @tranies = ['Select transmission...']
    end
  end


  def edit
    if current_user.car == nil
      redirect_to new_car_path
    else
      @car = current_user.car
      @years = Car.uniq.pluck(:year).sort
      params[:year] = @car.year
      self.update_makes
      params[:make] = @car.make
      self.update_models
      params[:model] = @car.model
      self.update_tranies
      params[:trany] = @car.trany
    end
  end


  def create
    year = params[:car][:year]
    make = params[:car][:make]
    model = params[:car][:model]
    trany = params[:car][:trany]
    current_user.car_id = Car.find_by(year: year, make: make, model: model, trany: trany).id

    respond_to do |format|
      if current_user.save
        format.html { redirect_to gas_prices_path, notice: 'Your car profile was successfully updated.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    self.create
  end


  def update_makes
    year = params[:year]
    @makes = Car.uniq.where(year: year).pluck(:make).sort_by{|x| x.downcase}
    @makes.insert(0,'Select make...')
  end

  def update_models
    year = params[:year]
    make = params[:make]
    @models = Car.uniq.where(year: year, make: make).pluck(:model).sort_by{|x| x.downcase}
    @models.insert(0,'Select model...')
  end

  def update_tranies
    year = params[:year]
    make = params[:make]
    model = params[:model]
    @tranies = Car.uniq.where(year: year, make: make, model: model).pluck(:trany).sort_by{|x| x.downcase}
    if @tranies.size == 0
      @tranies = ['<no transmission data>']
    end
    @tranies.insert(0,'Select transmission...')
  end

  private
  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:gas_grade_id, :vehicle_type)
  end
end
