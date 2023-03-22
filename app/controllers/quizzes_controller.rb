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
    @user = current_user
    @quiz = Quiz.find(params[:id])
    @total = 0
    @quiz.quiz_questions.each do |q|
      if q.user_answer == q.question.correct_answer
        @total += 1
      end
    end
    @score = 10 * @total
    @user.point += @score
    @user.save!


    if @total == 10
      @new_pokemons = Pokemon.all.sample(4)
    elsif @total >= 6
      @new_pokemons = Pokemon.all.sample(3)
    elsif @total >= 1
      @new_pokemons = Pokemon.all.sample(2)
    else
      @new_pokemons = Pokemon.all.sample(1)
    end
    @new_pokemons.each do |pokemon|
      UserPokemon.create(user: @user, pokemon: pokemon)
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:element)
  end
end
