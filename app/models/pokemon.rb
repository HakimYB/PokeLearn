class Pokemon < ApplicationRecord
  has_many :users, through: :user_pokemons

  def types
    JSON.parse(self.pokemon_type)
  end
  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true }
    }

end
