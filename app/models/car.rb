class Car < ActiveRecord::Base
  belongs_to :gas_grade
  has_many :users
end
