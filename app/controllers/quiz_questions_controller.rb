class QuizQuestionsController < ApplicationController

  def show
    @quiz_question = QuizQuestion.find(params[:id])
  end

  private

  def quiz_params
    params.require(:quiz).permit(:total)
  end
end
