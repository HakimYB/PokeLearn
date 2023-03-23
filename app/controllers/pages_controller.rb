require "json"
require "open-uri"


class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = User.new
  end

  def dashboard
    if params[:query].present?
      @user_pokemons = UserPokemon.search_by_pokemon(params[:query]).where(user: current_user)
    else
      @user_pokemons = UserPokemon.where(user: current_user)
    end
    name = @user_pokemons.first.pokemon.name
    url = "https://pokeapi.co/api/v2/pokemon/#{name}/"
    pokemon = JSON.parse(URI.open(url).read)

    @abilities = pokemon["ablities"]

    pokemon_species.each do |species|
      species_data = JSON.parse(URI.open(species['url']).read)
      name = species_data['name'

  end

  def map
  end
end
