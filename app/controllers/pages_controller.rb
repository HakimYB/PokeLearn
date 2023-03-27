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
    end
    @current_pokemon = @user_pokemons.first.pokemon
    name = @current_pokemon.name
    url = "https://pokeapi.co/api/v2/pokemon/#{name}/"
    @pokemon = JSON.parse(URI.open(url).read)
    species_url = "https://pokeapi.co/api/v2/pokemon-species/#{@current_pokemon.id}/"
    @description = JSON.parse(URI.open(species_url).read)
  end

  def map
  end
end
