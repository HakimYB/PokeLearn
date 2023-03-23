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
  end

  def map
  end
end
