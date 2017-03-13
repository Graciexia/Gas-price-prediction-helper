 module CarsHelper
  def calculate_gas_price(date, city_id, gas_grade_id)
    GasPrice.where('date <= ? and city_id = ? and gas_grade_id = ?',
                   date, city_id, gas_grade_id).first.gas_price || 0.0
  end

  def find_sipper_gas_grade_id
    #2010 Mazda 3
    Car.where(make:'Mazda', model:'3', trany: 'Manual 6-spd', year:2010).first.gas_grade_id
  end

  def find_guzzler_gas_grade_id
    # 2014 Bugatti Veyron
    Car.where(make:'Bugatti', model:'Veyron',year:2014).first.gas_grade_id
  end
end
