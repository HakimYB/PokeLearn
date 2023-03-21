class QuizzesController < ApplicationController

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to quiz_path(@quiz)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def quiz_params
    params.require(:quiz).permit(:total)
  end
end
