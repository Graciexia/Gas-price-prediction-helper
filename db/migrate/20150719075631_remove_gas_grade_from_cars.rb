class RemoveGasGradeFromCars < ActiveRecord::Migration
  def change
    remove_column :cars, :gas_grade, :string
  end
end
