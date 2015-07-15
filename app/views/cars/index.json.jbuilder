json.array!(@cars) do |car|
  json.extract! car, :id, :fuel_type, :vehiicle_type
  json.url car_url(car, format: :json)
end
