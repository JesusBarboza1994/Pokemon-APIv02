require 'httparty'
require 'json'

# This class is just for seed the db.
puts "Delete Pokemons"
Pokemon.destroy_all

puts "Delete Types"
Type.destroy_all

puts "Delete My Pokemons"
MyPokemon.destroy_all

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

stat_name = ["hp", "attack", "defense", "special_attack", "special_defense", "speed"]

stat_name.each do |stat|
  Stat.create(name:stat)
end

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

# url = 'https://pokeapi.co/api/v2/pokemon?limit=151'
url = 'https://pokeapi.co/api/v2/pokemon?limit=20'
pokemons = pokemons_info(url)
pokemons[:results].each.with_index do |pokemon,i|
  url_pokemon = pokemons_info(pokemon[:url])
  # image = URI.open(url_pokemon[:sprites][:front_default])
  puts "Creating Pokemon N°#{i+1}"
  pokemon = Pokemon.create(name: pokemon[:name], weight: url_pokemon[:weight], height: url_pokemon[:height],base_experience:url_pokemon[:base_experience], image: url_pokemon[:sprites][:front_default])
  # pokemon.cover.attach(io: image, filename: 'name.png', content_type: 'image/png')
  url_pokemon[:types].each do |type_name|
    type = Type.find_by(name:type_name[:type][:name])
    pokemon.types.push(type)
  end
  Stat.all.each.with_index do |stat,i|
    PokemonStat.create(stat:stat, pokemon:pokemon, base_stat:url_pokemon[:stats][i][:base_stat] , effort:url_pokemon[:stats][i][:effort] )
  end
end

User.create(username:"admin", birthday:Date.today, email:"jbarz20@gmail.com", role:"admin")

4.times.each do |i|
  User.create(username:"user#{i+1}", birthday:Date.today, email:"user#{i+1}@gmail.com", role:"member")
end

50.times.each do |i|
  MyPokemon.create(user:User.all.sample, pokemon:Pokemon.all.sample, nickname:"mypokemon#{i+1}", experience:0, level:1)
end

MyPokemon.all.each do |my_pokemon|
  IndivStat.create(my_pokemon: my_pokemon, hp:rand(0..31), attack:rand(0..31), defense:rand(0..31), special_attack:rand(0..31), special_defense:rand(0..31), speed:rand(0..31))
  EffortStat.create(my_pokemon: my_pokemon, hp:0, attack:0, defense:0, special_attack:0, special_defense:0, speed:0)
  stats=[]
  stat_name.each.with_index do |stat, i|
   if stat ==  "hp"
    hp = ((my_pokemon.pokemon.pokemon_stats[i][:base_stat]*2+my_pokemon.indiv_stat[stat]+my_pokemon.effort_stat[stat])*my_pokemon.level/100 + my_pokemon.level + 10).floor
    stats.push(hp)
   else
    statelse = ((my_pokemon.pokemon.pokemon_stats[i][:base_stat]*2+my_pokemon.indiv_stat[stat]+my_pokemon.effort_stat[stat])*my_pokemon.level/100 + 5).floor
    stats.push(statelse)
   end
  end 
  RealStat.create(my_pokemon: my_pokemon, hp:stats[0], attack:stats[1], defense:stats[2], special_attack:stats[3], special_defense:stats[4], speed:stats[5])
end