require 'csv'

["Regular","Midgrade","Premium"].each do |type|
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
