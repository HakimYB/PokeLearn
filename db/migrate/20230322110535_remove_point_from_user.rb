class RemovePointFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :point, :integer
  end
end
