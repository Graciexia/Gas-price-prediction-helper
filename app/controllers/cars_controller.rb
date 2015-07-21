class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    if current_user.car == nil
      redirect_to new_car_path
    else
      current_id = current_user.car_id
      @user_car = Car.find(current_id)
      @city_mileage = @user_car.city_mileage
      @highway_mileage = @user_car.highway_mileage
      @comb_mileage = @user_car.comb_mileage
      city_id = current_user.city_id
      gas_grade_id = current_user.car.gas_grade_id
      @grade_name = current_user.car.gas_grade.grade_name
      @car_name = "#{@user_car.year.to_s} #{@user_car.make} #{@user_car.model} (#{@user_car.trany})"
      date = Date.today
      gas_price_obj = GasPrice.where('date <= ? and city_id = ? and gas_grade_id = ?',
                                     date, city_id, gas_grade_id)
      @user_gas_price = gas_price_obj.first.gas_price || 0.0
      @sipper_gas_price = GasPrice.find_by('date <= ? and city_id = ? and gas_grade_id = ?',
                                     date, city_id, 1).gas_price || 0.0
      @guzzler_gas_price = GasPrice.find_by('date <= ? and city_id = ? and gas_grade_id = ?',
                                           date, city_id, 3).gas_price || 0.0
    end
  end

  def show
    current_id = current_user.car_id
    @car = Car.find(current_id)
    @city_name = current_user.city.name
  end

  # GET /cars/new
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

  # GET /cars/1/edit
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

  # POST /cars
  # POST /cars.json
  def create
    year = params[:car][:year]
    make = params[:car][:make]
    model = params[:car][:model]
    trany = params[:car][:trany]
    current_user.car_id = Car.find_by(year: year, make: make, model: model, trany: trany).id

    respond_to do |format|
      if current_user.save
        format.html { redirect_to gas_prices_path, notice: 'Your car profile was successfully updated.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    self.create
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
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

  def update_submit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:gas_grade_id, :vehicle_type)
    end
end
