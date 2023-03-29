class QuizzesController < ApplicationController
  before_action :set_pokemon_ids, only: [:new]

  def new
    @quiz = Quiz.new
    if params[:query].present?
      @pokemons = Pokemon.search_by_name(params[:query])
    else
      @pokemons = Pokemon.all
    end
    @elements = ["bug", "ground", "normal", "water", "fighting", "fire",
      "psychic", "grass", "rock", "electric", "poison", "ghost", "ice",
      "dragon", "fairy"]
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user
    if @quiz.save
      Question.order(Arel.sql('RANDOM()')).first(5).each do |question|
        QuizQuestion.create(quiz: @quiz, question: question)
      end
      redirect_to quiz_question_path(@quiz.quiz_questions.first)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    @quiz = Quiz.find(params[:id])
    @quiz.total = 0
    @quiz.quiz_questions.each do |q|
      if q.user_answer == q.question.correct_answer
        @quiz.total += 1
      end
    end
    @quiz.score = 10 * @quiz.total
    @previous_total = @user.point
    @user.point += @quiz.score
    @user.save!
    @pokemon_of_type = Pokemon.all.select do |pokemon|
     pokemon.types.include?(@quiz.element)
    end

    if @quiz.total == 5
      @new_pokemons = @pokemon_of_type.sample(3)
    elsif @quiz.total >= 2
      @new_pokemons = @pokemon_of_type.sample(2)
    else
      @new_pokemons = @pokemon_of_type.sample(1)
    end
    @new_pokemons.each do |pokemon|
      UserPokemon.create(user: @user, pokemon: pokemon)
      # raise
    end

    @completed = Quiz.find(params[:id])
    @wrong = @completed.quiz_questions.select do |f|
      f.user_answer != f.question.correct_answer
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:element)
  end

  def set_pokemon_ids
    @pokemon_ids = current_user.pokemon_ids if current_user.present?
  end
end
