class QuizzesController < ApplicationController

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user
    if @quiz.save
      10.times do
        QuizQuestion.create(quiz: @quiz, question: Question.all.sample)
      end
      redirect_to quiz_question_path(@quiz.quiz_questions.first)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def quiz_params
    params.require(:quiz).permit(:element)
  end
end
