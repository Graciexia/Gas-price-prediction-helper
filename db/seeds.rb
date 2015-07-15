
["Regular","Midgrade","Premium"].each do |type|
  GasGrade.create(grade_name: type)
end

cities =  City.all
cars = Car.all
gas_grades = GasGrade.all
20.times do
  user = User.create(name: Faker::Name.name,
               email: Faker::Internet.email,
               password: "12345678", password_confirmation: "12345678",
               address: Faker::Address.street_address,
               zipcode: Faker::Address.zip,
               city_id: cities.sample.id,
               car_id: cars.sample.id)
end




