class AddElementToQuizzes < ActiveRecord::Migration[7.0]
  def change
    add_column :quizzes, :element, :string
  end
end
