# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'json'
require 'open-uri'
require 'cgi'

puts 'Cleaning database...'
Pokemon.destroy_all
Question.destroy_all
User.destroy_all

puts "Creating User data..."
ayano = User.create!(username: "Ayano", email: "ayano@gmail.com", password: 123456)
hakim = User.create!(username: "Hakim", email: "hakim@gmail.com", password: 123456)
francois = User.create!(username: "Francois",  email: "francois@gmail.com", password: 123456)
abdullah = User.create!(username: "Abdullah", email: "abdullah@gmail.com", password: 123456)

puts 'Creating Pokemon data...'
gen1_url = 'https://pokeapi.co/api/v2/generation/1'
gen1_data = JSON.parse(URI.open(gen1_url).read)
pokemon_species = gen1_data['pokemon_species']

pokemon_species.each do |species|
  species_data = JSON.parse(URI.open(species['url']).read)
  name = species_data['name']
  types = species_data['types']
  if types.nil? || types.empty?
    pokemon_data = JSON.parse(URI.open("https://pokeapi.co/api/v2/pokemon/#{name}/").read)
    types = pokemon_data['types']
  end

  type_names = types.map { |type_data| type_data['type']['name'] } if types.present?

  evolution_url = species_data['evolution_chain']['url']
  evolution_data = JSON.parse(URI.open(evolution_url).read)
  chain = evolution_data['chain']

  species_data = JSON.parse(URI.open("https://pokeapi.co/api/v2/pokemon/#{name}/").read)
  image_url = species_data.dig('sprites', 'other', 'official-artwork', 'front_default')
  pokemon = Pokemon.create!(name: name, pokemon_type: type_names, image_url: image_url)
  while chain['evolves_to'].size > 0
    evolves_to_species = chain['evolves_to'][0]['species']
    evolves_to_name = evolves_to_species['name']
    if pokemon.evolves_to.nil?
      pokemon = Pokemon.find_by(name: name)
    else
      pokemon = Pokemon.find_by(name: pokemon.evolves_to)
    end
    pokemon.update(evolves_to: evolves_to_name) if pokemon && pokemon.name != evolves_to_name
    chain = chain['evolves_to'][0]
  end
end

puts 'Creating Question data...'
for i in 0..19 do
  url = "https://opentdb.com/api.php?amount=10&category=#{i}&difficulty=easy&type=multiple"
  data = JSON.parse(URI.open(url).read)
  data['results'].each do |question|
    correct_answer = question['correct_answer']
    incorrect_answers = question['incorrect_answers']
    incorrect_answer1 = incorrect_answers[0] || ''
    incorrect_answer2 = incorrect_answers[1] || ''
    problem = CGI.unescapeHTML(question['question']).gsub(/&([#0-9A-Za-z]+);/, "").gsub(/&#039;/, "'")
    category = question['category']
    Question.create!(
      problem: problem,
      correct_answer: correct_answer,
      incorrect_answer: incorrect_answers[0],
      incorrect_answer1: incorrect_answers[1],
      incorrect_answer2: incorrect_answers[2],
      category: category
    )
  end
end
users = User.all
users.each do |user|
  user.pokemons = Pokemon.all.sample(3)
end
puts 'Seed data generated!'
