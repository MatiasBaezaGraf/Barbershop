class AddDayToFreetimes < ActiveRecord::Migration[6.1]
  def change
    add_column :freetimes, :day, :date
  end
end
