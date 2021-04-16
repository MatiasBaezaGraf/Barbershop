class CreateHasTurns < ActiveRecord::Migration[6.1]
  def change
    create_table :has_turns do |t|
      t.references :turn, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
