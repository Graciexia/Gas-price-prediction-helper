every 1.day, :at => '4:30 am' do
  runner "GasPrice.k_update_gas_data", environment: 'development'
end

every 1.day, :at => '4:45 am' do
  runner "GasPrice.my_update_gas_data", environment: 'development'
end

every 1.day, :at => '4:50 am' do
  runner "OilPrice.k_update_oil_data", environment: 'development'
end

every 1.day, :at => '4:55 am' do
  runner "OilPrice.my_update_oil_data", environment: 'development'
end
