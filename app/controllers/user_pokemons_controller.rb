class UserPokemonsController < ApplicationController

  def evolve
    @user = current_user

    if @user.point >= 50
      @user.point -= 50
      @user.save
      @old_pokemon = UserPokemon.find(params[:id])
      @new_pokemon = Pokemon.find_by(name: @old_pokemon.pokemon.evolves_to)
      @evolved = UserPokemon.create(pokemon: @new_pokemon, user: @user)

      flash[:notice] = "New pokemon added to Pokedex!"
      redirect_to pokedex_path
    else
      flash[:alert] = "You don't have enough points..."
      redirect_to pokedex_path
    end
  end
end
