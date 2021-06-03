class CreateFreetimes < ActiveRecord::Migration[6.1]
  def change
    create_table :freetimes do |t|
      t.datetime :from
      t.datetime :to
      t.integer :permanent
      t.integer :barber_id

      t.timestamps
    end
  end
end
