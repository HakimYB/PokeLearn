class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :correct_answer
      t.string :incorrect_answer
      t.text :problem

      t.timestamps
    end
  end
end
