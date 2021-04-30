class AddClientToTurn < ActiveRecord::Migration[6.1]
  def change
    add_column :turns, :client, :string
  end
end
