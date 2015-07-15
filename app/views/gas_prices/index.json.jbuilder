json.array!(@gas_prices) do |gas_price|
  json.extract! gas_price, :id, :daily_price, :gas_type
  json.url gas_price_url(gas_price, format: :json)
end
