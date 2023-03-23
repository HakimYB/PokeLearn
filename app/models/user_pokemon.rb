class UserPokemon < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user

  include PgSearch::Model
  pg_search_scope :search_by_pokemon,
    associated_against: {
      pokemon: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
