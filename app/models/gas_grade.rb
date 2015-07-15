class GasGrade < ActiveRecord::Base
  has_many :cars
  has_many :gas_prices
end
