class AddEvolvesToToPokemons < ActiveRecord::Migration[7.0]
  def change
    add_column :pokemons, :evolves_to, :string
  end
end
