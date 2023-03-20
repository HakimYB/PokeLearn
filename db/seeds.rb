# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'json'
require 'open-uri'

puts 'Cleaning database...'
Pokemon.destroy_all

puts 'Creating Pokemon data...'
gen1_url = 'https://pokeapi.co/api/v2/generation/1'
gen1_data = JSON.parse(URI.open(gen1_url).read)
pokemon_species = gen1_data['pokemon_species']

pokemon_species.each do |species|
  species_data = JSON.parse(URI.open(species['url']).read)
  name = species_data['name']
  types = species_data['types'] ? species_data['types'].map { |type_data| type_data['type']['name'] } : []
  evolution_url = species_data['evolution_chain']['url']
  evolution_data = JSON.parse(URI.open(evolution_url).read)
  # evolution_chain = []
  # current_species = evolution_data['chain']['species']['name']
  # evolution_chain.append(current_species)
  name_evolution = nil
  if evolution_data.dig("chain","evolves_to").present?
    name_evolution = evolution_data["chain"]["evolves_to"][0]["species"]["name"]
    # evolution_chain.append(current_evolution)
    # evolution_data = evolution_data["chain"]["evolves_to"][0]
  end
  species_data = JSON.parse(URI.open("https://pokeapi.co/api/v2/pokemon/#{name}/").read)
  image_url = species_data.dig('sprites', 'other', 'official-artwork', 'front_default')
  Pokemon.create!(name: name, pokemon_type: types, evolves_to: name_evolution, image_url: image_url)
end

puts 'Seed data generated!'
