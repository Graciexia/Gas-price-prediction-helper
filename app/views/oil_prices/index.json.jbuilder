json.array!(@oil_prices) do |oil_price|
  json.extract! oil_price, :id, :daily_oil_price, :date
  json.url oil_price_url(oil_price, format: :json)
end
