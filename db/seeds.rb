require 'httparty'
require 'json'

# This class is just for seed the db.
puts "Delete Pokemons"
Pokemon.destroy_all

puts "Delete Types"
Type.destroy_all

colours = {
normal: '#A8A77A',
fighting: '#C22E28',
flying: '#A98FF3',
poison: '#A33EA1',
ground: '#E2BF65',
rock: '#B6A136',
bug: '#A6B91A',
ghost: '#735797',
steel: '#B7B7CE',
fire: '#EE8130',
water: '#6390F0',
grass: '#7AC74C',
electric: '#F7D02C',
ice: '#96D9D6',
psychic: '#F95587',
dragon: '#6F35FC',
dark: '#705746',
fairy: '#D685AD',
shadow: '#7851A8'
}

def pokemons_info(url)
  response = HTTParty.get(url)
  raise ResponseError, response unless response.success?
  JSON.parse(response.body, symbolize_names: true)
end

puts "Creating types"

url_type = 'https://pokeapi.co/api/v2/type'
types = pokemons_info(url_type)
types[:results].each do |type|
  actual_type = Type.create(name:type[:name], color: colours[type[:name].to_sym])
end

url = 'https://pokeapi.co/api/v2/pokemon?limit=151'
# url = 'https://pokeapi.co/api/v2/pokemon?limit=20'
pokemons = pokemons_info(url)
pokemons[:results].each.with_index do |pokemon,i|
  url_pokemon = pokemons_info(pokemon[:url])
  # image = URI.open(url_pokemon[:sprites][:front_default])
  puts "Creating Pokemon N°#{i+1}"
  pokemon = Pokemon.create(name: pokemon[:name], weight: url_pokemon[:weight], height: url_pokemon[:height], image: url_pokemon[:sprites][:front_default])
  # pokemon.cover.attach(io: image, filename: 'name.png', content_type: 'image/png')
  url_pokemon[:types].each do |type_name|
    type = Type.find_by(name:type_name[:type][:name])
    pokemon.types.push(type)
  end
end

