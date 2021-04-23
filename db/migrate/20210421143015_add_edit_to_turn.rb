class AddEditToTurn < ActiveRecord::Migration[6.1]
  def change
    add_column :turns, :edit, :integer
  end
end
