class Question < ApplicationRecord
  has_many :quiz_questions
  has_many :quizzes, through: :quiz_questions
end
