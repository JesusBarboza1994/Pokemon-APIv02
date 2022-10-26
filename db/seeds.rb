require 'httparty'
require 'json'

# This class is just for seed the db.
Pokemon.destroy_all
Type.destroy_all


def pokemons_info(url)
  response = HTTParty.get(url)
  raise ResponseError, response unless response.success?

  JSON.parse(response.body, symbolize_names: true)
end

puts "Creating types"

url_type = 'https://pokeapi.co/api/v2/type'
types = pokemons_info(url_type)
types[:results].each do |type|
  Type.create(name:type[:name])
end

i=0
url = 'https://pokeapi.co/api/v2/pokemon?limit=151'
pokemons = pokemons_info(url)
pokemons[:results].each do |pokemon|
  url_pokemon = pokemons_info(pokemon[:url])
  # image = URI.open(url_pokemon[:sprites][:front_default])
  puts "Creating Pokemon N°#{i}"
  pokemon = Pokemon.create(name: pokemon[:name], weight: url_pokemon[:weight], height: url_pokemon[:height], image: url_pokemon[:sprites][:front_default])
  # pokemon.cover.attach(io: image, filename: 'name.png', content_type: 'image/png')
  url_pokemon[:types].each do |type_name|
    type = Type.find_by(name:type_name[:type][:name])
    pokemon.types.push(type)
  end
  i+=1
end

