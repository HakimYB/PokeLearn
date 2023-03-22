class AddIncorrectAnswer2ToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :incorrect_answer2, :string
  end
end
