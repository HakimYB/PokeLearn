class Question < ApplicationRecord
  has_many :quiz_questions, dependent: :destroy
  has_many :quizzes, through: :quiz_questions
end
