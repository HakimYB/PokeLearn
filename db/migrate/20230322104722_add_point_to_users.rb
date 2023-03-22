class AddPointToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :point, :integer
  end
end
