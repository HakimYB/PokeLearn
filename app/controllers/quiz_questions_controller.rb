class QuizQuestionsController < ApplicationController

  def show
    @quiz_question = QuizQuestion.find(params[:id])
    @answer = @quiz_question.question.correct_answer
    @incorrect = @quiz_question.question.incorrect_answer
    @problem = @quiz_question.question.problem
  end

  def edit
  end

  def update

    if @problem.user_answer?

    else

    end

  end

  private

  def quiz_question_params
    params.require(:quiz).permit(:user_answer)
  end
end
