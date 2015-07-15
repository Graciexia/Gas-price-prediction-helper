class City < ActiveRecord::Base
  has_many :gas_prices
  has_many :users
  has_many :cars, through: :users
  has_many :gas_grades, through: :gas_prices
end
