require "json"
require "open-uri"


class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = User.new
    @user = Pokemon.all.sample(3)
    @user.each do |p|
      UserPokemon.create(user: current_user, pokemon: p)
    end
  end

  def dashboard
    if params[:query].present?
      @user_pokemons = UserPokemon.search_by_pokemon(params[:query]).where(user: current_user)
    else
      @user_pokemons = UserPokemon.where(user: current_user)
      @testing_pokemon = UserPokemon.where(user: current_user).select("distinct pokemon_id").order("pokemon_id DESC")
      # @user_pokemons.pokemon
      # raise
    #   unique_ids = @user_pokemons.select("distinct pokemon_id").map{|element| element.pokemon_id}
    #   @user_pokemons.map{|user_pokemon| unique_ids.include?(user_pokemon.pokemon.id)}
    end

    if @user_pokemons.exists?
      @current_pokemon = @user_pokemons.first.pokemon
      @current_user_pokemon = @user_pokemons.first
      name = @current_pokemon.name
      url = "https://pokeapi.co/api/v2/pokemon/#{name}/"
      @pokemon = JSON.parse(URI.open(url).read)
      species_url = "https://pokeapi.co/api/v2/pokemon-species/#{@current_pokemon.id}/"
      @description = JSON.parse(URI.open(species_url).read)
    end
  end

  def dashboard_show
    if params[:query].present?
      @user_pokemons = UserPokemon.search_by_pokemon(params[:query]).where(user: current_user)
    else
      @user_pokemons = UserPokemon.where(user: current_user).order("created_at DESC")
    end

    @current_pokemon = Pokemon.find(params[:id])
    @current_user_pokemon = @user_pokemons.find_by(pokemon: @current_pokemon)

    name = @current_pokemon.name
    url = "https://pokeapi.co/api/v2/pokemon/#{name}/"
    @pokemon = JSON.parse(URI.open(url).read)
    species_url = "https://pokeapi.co/api/v2/pokemon-species/#{@current_pokemon.id}/"
    @description = JSON.parse(URI.open(species_url).read)
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "pages/big_card", locals: { current_pokemon:@current_pokemon, pokemon:@pokemon, description:@description }, formats: [:html] }
    end
  end

  def map
  end
end
