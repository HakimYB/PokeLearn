class Pokemon < ApplicationRecord
  has_many :users, through: :user_pokemons
end
