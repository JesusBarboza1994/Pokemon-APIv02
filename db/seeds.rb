require 'httparty'
require 'json'

puts "Delete Pokemons"
Pokemon.destroy_all

puts "Delete Types"
Type.destroy_all

puts "Delete My Pokemons"
MyPokemon.destroy_all

pokemons_image = {"Bulbasaur":"http://img.pokemondb.net/artwork/bulbasaur.jpg","Ivysaur":"http://img.pokemondb.net/artwork/ivysaur.jpg","Venusaur":"http://img.pokemondb.net/artwork/venusaur.jpg","Charmander":"http://img.pokemondb.net/artwork/charmander.jpg","Charmeleon":"http://img.pokemondb.net/artwork/charmeleon.jpg","Charizard":"http://img.pokemondb.net/artwork/charizard.jpg","Squirtle":"http://img.pokemondb.net/artwork/squirtle.jpg","Wartortle":"http://img.pokemondb.net/artwork/wartortle.jpg","Blastoise":"http://img.pokemondb.net/artwork/blastoise.jpg","Caterpie":"http://img.pokemondb.net/artwork/caterpie.jpg","Metapod":"http://img.pokemondb.net/artwork/metapod.jpg","Butterfree":"http://img.pokemondb.net/artwork/butterfree.jpg","Weedle":"http://img.pokemondb.net/artwork/weedle.jpg","Kakuna":"http://img.pokemondb.net/artwork/kakuna.jpg","Beedrill":"http://img.pokemondb.net/artwork/beedrill.jpg","Pidgey":"http://img.pokemondb.net/artwork/pidgey.jpg","Pidgeotto":"http://img.pokemondb.net/artwork/pidgeotto.jpg","Pidgeot":"http://img.pokemondb.net/artwork/pidgeot.jpg","Rattata":"http://img.pokemondb.net/artwork/rattata.jpg","Raticate":"http://img.pokemondb.net/artwork/raticate.jpg","Spearow":"http://img.pokemondb.net/artwork/spearow.jpg","Fearow":"http://img.pokemondb.net/artwork/fearow.jpg","Ekans":"http://img.pokemondb.net/artwork/ekans.jpg","Arbok":"http://img.pokemondb.net/artwork/arbok.jpg","Pikachu":"http://img.pokemondb.net/artwork/pikachu.jpg","Raichu":"http://img.pokemondb.net/artwork/raichu.jpg","Sandshrew":"http://img.pokemondb.net/artwork/sandshrew.jpg","Sandslash":"http://img.pokemondb.net/artwork/sandslash.jpg","Nidoran-f":"http://img.pokemondb.net/artwork/nidoran-f.jpg","Nidorina":"http://img.pokemondb.net/artwork/nidorina.jpg","Nidoqueen":"http://img.pokemondb.net/artwork/nidoqueen.jpg","Nidoran-m":"http://img.pokemondb.net/artwork/nidoran-m.jpg","Nidorino":"http://img.pokemondb.net/artwork/nidorino.jpg","Nidoking":"http://img.pokemondb.net/artwork/nidoking.jpg","Clefairy":"http://img.pokemondb.net/artwork/clefairy.jpg","Clefable":"http://img.pokemondb.net/artwork/clefable.jpg","Vulpix":"http://img.pokemondb.net/artwork/vulpix.jpg","Ninetales":"http://img.pokemondb.net/artwork/ninetales.jpg","Jigglypuff":"http://img.pokemondb.net/artwork/jigglypuff.jpg","Wigglytuff":"http://img.pokemondb.net/artwork/wigglytuff.jpg","Zubat":"http://img.pokemondb.net/artwork/zubat.jpg","Golbat":"http://img.pokemondb.net/artwork/golbat.jpg","Oddish":"http://img.pokemondb.net/artwork/oddish.jpg","Gloom":"http://img.pokemondb.net/artwork/gloom.jpg","Vileplume":"http://img.pokemondb.net/artwork/vileplume.jpg","Paras":"http://img.pokemondb.net/artwork/paras.jpg","Parasect":"http://img.pokemondb.net/artwork/parasect.jpg","Venonat":"http://img.pokemondb.net/artwork/venonat.jpg","Venomoth":"http://img.pokemondb.net/artwork/venomoth.jpg","Diglett":"http://img.pokemondb.net/artwork/diglett.jpg","Dugtrio":"http://img.pokemondb.net/artwork/dugtrio.jpg","Meowth":"http://img.pokemondb.net/artwork/meowth.jpg","Persian":"http://img.pokemondb.net/artwork/persian.jpg","Psyduck":"http://img.pokemondb.net/artwork/psyduck.jpg","Golduck":"http://img.pokemondb.net/artwork/golduck.jpg","Mankey":"http://img.pokemondb.net/artwork/mankey.jpg","Primeape":"http://img.pokemondb.net/artwork/primeape.jpg","Growlithe":"http://img.pokemondb.net/artwork/growlithe.jpg","Arcanine":"http://img.pokemondb.net/artwork/arcanine.jpg","Poliwag":"http://img.pokemondb.net/artwork/poliwag.jpg","Poliwhirl":"http://img.pokemondb.net/artwork/poliwhirl.jpg","Poliwrath":"http://img.pokemondb.net/artwork/poliwrath.jpg","Abra":"http://img.pokemondb.net/artwork/abra.jpg","Kadabra":"http://img.pokemondb.net/artwork/kadabra.jpg","Alakazam":"http://img.pokemondb.net/artwork/alakazam.jpg","Machop":"http://img.pokemondb.net/artwork/machop.jpg","Machoke":"http://img.pokemondb.net/artwork/machoke.jpg","Machamp":"http://img.pokemondb.net/artwork/machamp.jpg","Bellsprout":"http://img.pokemondb.net/artwork/bellsprout.jpg","Weepinbell":"http://img.pokemondb.net/artwork/weepinbell.jpg","Victreebel":"http://img.pokemondb.net/artwork/victreebel.jpg","Tentacool":"http://img.pokemondb.net/artwork/tentacool.jpg","Tentacruel":"http://img.pokemondb.net/artwork/tentacruel.jpg","Geodude":"http://img.pokemondb.net/artwork/geodude.jpg","Graveler":"http://img.pokemondb.net/artwork/graveler.jpg","Golem":"http://img.pokemondb.net/artwork/golem.jpg","Ponyta":"http://img.pokemondb.net/artwork/ponyta.jpg","Rapidash":"http://img.pokemondb.net/artwork/rapidash.jpg","Slowpoke":"http://img.pokemondb.net/artwork/slowpoke.jpg","Slowbro":"http://img.pokemondb.net/artwork/slowbro.jpg","Magnemite":"http://img.pokemondb.net/artwork/magnemite.jpg","Magneton":"http://img.pokemondb.net/artwork/magneton.jpg","Farfetchd":"http://img.pokemondb.net/artwork/farfetchd.jpg","Doduo":"http://img.pokemondb.net/artwork/doduo.jpg","Dodrio":"http://img.pokemondb.net/artwork/dodrio.jpg","Seel":"http://img.pokemondb.net/artwork/seel.jpg","Dewgong":"http://img.pokemondb.net/artwork/dewgong.jpg","Grimer":"http://img.pokemondb.net/artwork/grimer.jpg","Muk":"http://img.pokemondb.net/artwork/muk.jpg","Shellder":"http://img.pokemondb.net/artwork/shellder.jpg","Cloyster":"http://img.pokemondb.net/artwork/cloyster.jpg","Gastly":"http://img.pokemondb.net/artwork/gastly.jpg","Haunter":"http://img.pokemondb.net/artwork/haunter.jpg","Gengar":"http://img.pokemondb.net/artwork/gengar.jpg","Onix":"http://img.pokemondb.net/artwork/onix.jpg","Drowzee":"http://img.pokemondb.net/artwork/drowzee.jpg","Hypno":"http://img.pokemondb.net/artwork/hypno.jpg","Krabby":"http://img.pokemondb.net/artwork/krabby.jpg","Kingler":"http://img.pokemondb.net/artwork/kingler.jpg","Voltorb":"http://img.pokemondb.net/artwork/voltorb.jpg","Electrode":"http://img.pokemondb.net/artwork/electrode.jpg","Exeggcute":"http://img.pokemondb.net/artwork/exeggcute.jpg","Exeggutor":"http://img.pokemondb.net/artwork/exeggutor.jpg","Cubone":"http://img.pokemondb.net/artwork/cubone.jpg","Marowak":"http://img.pokemondb.net/artwork/marowak.jpg","Hitmonlee":"http://img.pokemondb.net/artwork/hitmonlee.jpg","Hitmonchan":"http://img.pokemondb.net/artwork/hitmonchan.jpg","Lickitung":"http://img.pokemondb.net/artwork/lickitung.jpg","Koffing":"http://img.pokemondb.net/artwork/koffing.jpg","Weezing":"http://img.pokemondb.net/artwork/weezing.jpg","Rhyhorn":"http://img.pokemondb.net/artwork/rhyhorn.jpg","Rhydon":"http://img.pokemondb.net/artwork/rhydon.jpg","Chansey":"http://img.pokemondb.net/artwork/chansey.jpg","Tangela":"http://img.pokemondb.net/artwork/tangela.jpg","Kangaskhan":"http://img.pokemondb.net/artwork/kangaskhan.jpg","Horsea":"http://img.pokemondb.net/artwork/horsea.jpg","Seadra":"http://img.pokemondb.net/artwork/seadra.jpg","Goldeen":"http://img.pokemondb.net/artwork/goldeen.jpg","Seaking":"http://img.pokemondb.net/artwork/seaking.jpg","Staryu":"http://img.pokemondb.net/artwork/staryu.jpg","Starmie":"http://img.pokemondb.net/artwork/starmie.jpg","Mr-mime":"http://www.youloveit.ru/uploads/gallery/main/162/mr-mime.png","Scyther":"http://img.pokemondb.net/artwork/scyther.jpg","Jynx":"http://img.pokemondb.net/artwork/jynx.jpg","Electabuzz":"http://img.pokemondb.net/artwork/electabuzz.jpg","Magmar":"http://img.pokemondb.net/artwork/magmar.jpg","Pinsir":"http://img.pokemondb.net/artwork/pinsir.jpg","Tauros":"http://img.pokemondb.net/artwork/tauros.jpg","Magikarp":"http://img.pokemondb.net/artwork/magikarp.jpg","Gyarados":"http://img.pokemondb.net/artwork/gyarados.jpg","Lapras":"http://img.pokemondb.net/artwork/lapras.jpg","Ditto":"http://img.pokemondb.net/artwork/ditto.jpg","Eevee":"http://img.pokemondb.net/artwork/eevee.jpg","Vaporeon":"http://img.pokemondb.net/artwork/vaporeon.jpg","Jolteon":"http://img.pokemondb.net/artwork/jolteon.jpg","Flareon":"http://img.pokemondb.net/artwork/flareon.jpg","Porygon":"http://img.pokemondb.net/artwork/porygon.jpg","Omanyte":"http://img.pokemondb.net/artwork/omanyte.jpg","Omastar":"http://img.pokemondb.net/artwork/omastar.jpg","Kabuto":"http://img.pokemondb.net/artwork/kabuto.jpg","Kabutops":"http://img.pokemondb.net/artwork/kabutops.jpg","Aerodactyl":"http://img.pokemondb.net/artwork/aerodactyl.jpg","Snorlax":"http://img.pokemondb.net/artwork/snorlax.jpg","Articuno":"http://img.pokemondb.net/artwork/articuno.jpg","Zapdos":"http://img.pokemondb.net/artwork/zapdos.jpg","Moltres":"http://img.pokemondb.net/artwork/moltres.jpg","Dratini":"http://img.pokemondb.net/artwork/dratini.jpg","Dragonair":"http://img.pokemondb.net/artwork/dragonair.jpg","Dragonite":"http://img.pokemondb.net/artwork/dragonite.jpg","Mewtwo":"http://img.pokemondb.net/artwork/mewtwo.jpg","Mew":"http://img.pokemondb.net/artwork/mew.jpg"}
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

puts 'Creating moves'
url_moves = 'https://pokeapi.co/api/v2/move?limit=844'
# url_moves = 'https://pokeapi.co/api/v2/move?limit=10'
moves = pokemons_info(url_moves)
moves[:results].each_with_index do |move, i|
  data_move = pokemons_info(move[:url])
  puts "Move #{i + 1}"
  Move.create(name:data_move[:name], tipo: data_move[:type][:name], accuracy: data_move[:accuracy], priority: data_move[:priority], power:data_move[:power], pp: data_move[:pp])
end

puts 'Creating types'

url_type = 'https://pokeapi.co/api/v2/type'
types = pokemons_info(url_type)
types[:results].each do |type|
  Type.create(name:type[:name], color: colours[type[:name].to_sym])
end

url = 'https://pokeapi.co/api/v2/pokemon?limit=151'
# url = 'https://pokeapi.co/api/v2/pokemon?limit=10'
pokemons = pokemons_info(url)
pokemons[:results].each.with_index do |pokemon, i|
  url_pokemon = pokemons_info(pokemon[:url])
  # image = URI.open(url_pokemon[:sprites][:front_default])
  puts "Creating Pokemon N??#{i+1}"
  pokemon = Pokemon.create(name: pokemon[:name], weight: url_pokemon[:weight], height: url_pokemon[:height],base_experience:url_pokemon[:base_experience], image: pokemons_image[pokemon[:name].capitalize().to_sym])
  # pokemon.cover.attach(io: image, filename: 'name.png', content_type: 'image/png')
  url_pokemon[:types].each do |type_name|
    type = Type.find_by(name:type_name[:type][:name])
    pokemon.types.push(type)
  end

  url_pokemon[:moves].each do |move|
    move_main = Move.find_by(name: move[:move][:name])
    pokemon.moves.push(move_main) unless move_main.nil?
    
  end
  Stat.all.each.with_index do |stat, i|
    PokemonStat.create(stat: stat, pokemon: pokemon, base_stat:url_pokemon[:stats][i][:base_stat] , effort:url_pokemon[:stats][i][:effort] )
  end
end

User.create(username:"admin", birthday:Date.today, email:"admin@gmail.com", role:"admin", password: "qwerty", password_confirmation:"qwerty")

4.times.each do |i|
  User.create(username:"user#{i+1}", birthday:Date.today, email:"user#{i+1}@gmail.com", role:"member", password: "qwerty", password_confirmation:"qwerty")
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



Pokemon.all.each do |pokemon|

end


User.create(username:"bot", email:"mail@mail.com", role:"member", password: "qwerty", password_confirmation:"qwerty")

