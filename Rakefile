# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "Get all the oil data"
task :get_oil_and_gas_data => :environment do
  GasPrice.k_update_gas_data
  GasPrice.my_update_gas_data
  OilPrice.k_update_oil_data
  OilPrice.my_update_oil_data
end
