class AddCategoryToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :category, :string
  end
end
