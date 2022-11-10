class TrainController < ApplicationController
  def create
    @my_pokemon = MyPokemon.find(params[:my_pokemon_id])
    @pokemon = Pokemon.all.sample
    @bot = User.find_by(username:"bot")
    @bot_pokemon = MyPokemon.create(user:@bot, pokemon:@pokemon, 
                    nickname:@pokemon.name, experience:0, level:rand(1..(@my_pokemon.level+5)))
    puts @bot_pokemon
    # @bot_pokemon.train(@bot_pokemon)
    render "/train/create"
  end
end