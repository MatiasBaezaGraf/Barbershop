class CreateHolidays < ActiveRecord::Migration[6.1]
  def change
    create_table :holidays do |t|
      t.date :freeday
      t.integer :permanent
      t.references :barber, null: false, foreign_key: true

      t.timestamps
    end
  end
end
