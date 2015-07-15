class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :city_mileage
      t.integer :comb_mileage
      t.string :gas_grade
      t.integer :highway_mileage
      t.string :make
      t.string :model
      t.string :trany
      t.integer :year
      t.belongs_to :gas_grade

      t.timestamps null: false
    end
  end
end
