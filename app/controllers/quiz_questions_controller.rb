class QuizQuestionsController < ApplicationController

  def show
    @quiz_question = QuizQuestion.find(params[:id])
    @answer = @quiz_question.question.correct_answer
    @incorrect = @quiz_question.question.incorrect_answer
    @incorrect_two = @quiz_question.question.incorrect_answer1
    @incorrect_three = @quiz_question.question.incorrect_answer2
    @problem = @quiz_question.question.problem
    @user_answer = @quiz_question.user_answer

    check = @quiz_question.quiz.quiz_questions.select { |question| question.user_answer.nil? }
    @number = 10 - check.length + 1
  end

  def edit
  end

  def update
    p params
    # find quiz
    @quiz_question = QuizQuestion.find(params[:id])
    # asign user asnwer
    @quiz_question.user_answer = params[:quiz_question][:user_answer]
    # save
    @quiz_question.save!
    # search quiz for nect question
    @quiz = @quiz_question.quiz
    # find unanaswered q
    @unanswered_questions = @quiz.quiz_questions.select { |question| question.user_answer.nil? }
    # next q is an unanswered one
    @next_quiz_question = @unanswered_questions.sample
    # test if any unanswered
    if @unanswered_questions.empty?
      # if none left go to results
      redirect_to quiz_path(@quiz)
    else
      # or give next q
      redirect_to quiz_question_path(@next_quiz_question)
    end
  end

  private

  def quiz_question_params
    params.require(:quiz).permit(:user_answer)
  end
end
