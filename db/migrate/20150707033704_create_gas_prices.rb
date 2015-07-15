class CreateGasPrices < ActiveRecord::Migration
  def change
    create_table :gas_prices do |t|
      t.float :gas_price
      t.date :date
      t.belongs_to :city
      t.belongs_to :gas_grade

      t.timestamps null: false
    end
  end
end
