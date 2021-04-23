class AddPToTurn < ActiveRecord::Migration[6.1]
  def change
    add_column :turns, :p, :integer
  end
end
