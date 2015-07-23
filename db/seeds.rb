require 'csv'

gas_grade_array = ["Regular","Midgrade","Premium"]

gas_grade_array.each do |type|
  GasGrade.find_or_create_by(grade_name: type)
end

CSV.foreach("lib/assets/vehicles_short.csv") do |row|
  city_mileage = row[0].to_i
  comb_mileage = row[1].to_i
  gas_grade_lookup = row[2].to_s
  highway_mileage = row[3].to_i
  make = row[4].to_s
  model = row[5].to_s
  trany = row[6].to_s
  year = row[7].to_i
  if ! gas_grade_lookup.include? 'Electricity'
    gas_grade_lookup = 'Premium' if gas_grade_lookup.include? 'E85'
    gas_grade_lookup = 'Regular' if gas_grade_lookup[0..2] == 'Gas'
    if gas_grade_array.include?(gas_grade_lookup)
      if trany == nil || trany.strip == ''
        trany = '<not specified>'
      end
      Car.find_or_create_by(
          city_mileage: city_mileage,
          comb_mileage: comb_mileage,
          highway_mileage: highway_mileage,
          make: make,
          model: model,
          trany: trany,
          year: year,
          gas_grade: GasGrade.find_by_grade_name(gas_grade_lookup)
          )
    end
  end
end

GasPrice.k_update_gas_data
GasPrice.my_update_gas_data
OilPrice.k_update_oil_data
OilPrice.my_update_oil_data

cities =  City.all
cars = Car.all
20.times do
  User.create(name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "12345678", password_confirmation: "12345678",
      address: Faker::Address.street_address,
      zipcode: Faker::Address.zip,
      city_id: cities.sample.id,
      car_id: cars.sample.id)
end
