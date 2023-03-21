class AddIncorrectAnswer1ToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :incorrect_answer1, :string
  end
end
