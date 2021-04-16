class CreateHasBarbers < ActiveRecord::Migration[6.1]
  def change
    create_table :has_barbers do |t|
      t.references :barber, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
