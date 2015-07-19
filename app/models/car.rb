class Car < ActiveRecord::Base
  alias_attribute :grade_name, :gas_grade
  belongs_to :gas_grade
  has_many :users
end
