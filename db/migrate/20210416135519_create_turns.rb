class CreateTurns < ActiveRecord::Migration[6.1]
  def change
    create_table :turns do |t|
      t.datetime :time
      t.references :barber, null: false, foreign_key: true

      t.timestamps
    end
  end
end
