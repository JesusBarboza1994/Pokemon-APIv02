class TrainController < ApplicationController
  def index
    @my_pokemon = MyPokemon.find(params[:my_pokemon_id])
    @pokemon = Pokemon.all.sample
    @bot = User.create
  end
end