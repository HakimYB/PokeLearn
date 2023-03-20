class CreateQuizQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :user_answer

      t.timestamps
    end
  end
end
