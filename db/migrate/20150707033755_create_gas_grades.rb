class CreateGasGrades < ActiveRecord::Migration
  def change
    create_table :gas_grades do |t|
      t.string :grade_name

      t.timestamps null: false
    end
  end
end
