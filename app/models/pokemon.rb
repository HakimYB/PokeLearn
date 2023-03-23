class Pokemon < ApplicationRecord
  has_many :users, through: :user_pokemons

  def types
    JSON.parse(self.pokemon_type)
  end


end
