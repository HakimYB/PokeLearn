class RemoveColumnFromPokemon < ActiveRecord::Migration[7.0]
  def change
    remove_column :pokemons, :type, :string
  end
end
