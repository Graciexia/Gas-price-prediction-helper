class CreateOilPrices < ActiveRecord::Migration
  def change
    create_table :oil_prices do |t|
      t.float :oil_price
      t.date :date

      t.timestamps null: false
    end
  end
end
