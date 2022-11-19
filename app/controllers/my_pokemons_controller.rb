class MyPokemonsController < ApplicationController
  before_action :set_my_pokemon, only: %i[ show edit update destroy ]

  # GET /my_pokemons
  def index
    @my_pokemons = MyPokemon.where(user:current_user)

  end

  # GET /my_pokemons/1
  def show
  end

  # GET /my_pokemons/new
  def new
    @my_pokemon = MyPokemon.new
  end

  # GET /my_pokemons/1/edit
  def edit
  end

  # POST /my_pokemons
  def create
    @my_pokemon = MyPokemon.new(my_pokemon_params)
    create_stats(@my_pokemon)
    if @my_pokemon.save
      redirect_to @my_pokemon, notice: "My pokemon was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /my_pokemons/1
  def update
    if @my_pokemon.update(my_pokemon_params)
      redirect_to @my_pokemon, notice: "My pokemon was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /my_pokemons/1
  def destroy
    @my_pokemon.destroy
    redirect_to my_pokemons_url, notice: "My pokemon was successfully destroyed."
  end

  def train
    @my_pokemon = MyPokemon.find(params[:my_pokemon_id])
    @pokemon = Pokemon.all.sample 
    @bot = User.find_by(username:"bot")
    @bot_pokemon = MyPokemon.create(user:@bot, pokemon:@pokemon, 
                    nickname:@pokemon.name, experience:0, level:rand(1..(@my_pokemon.level+5)))
    create_stats(@bot_pokemon)
    @my_pokemon.update(actual_hp: @my_pokemon.real_stat[:hp] )
    @bot_pokemon.update(actual_hp: @bot_pokemon.real_stat[:hp] )
    @my_pokemon.prepare_for_battle
    @bot_pokemon.prepare_for_battle  
    
    render "train"
  end

  def attack
    puts "MYPOKEMON"
    p params
    @my_pokemon = MyPokemon.find(params[:my_pokemon_id])
    @bot_pokemon = MyPokemon.find(params[:bot_pokemon_id])
    @my_pokemon.attack(@bot_pokemon) 
    puts @bot_pokemon.actual_hp
    if @bot_pokemon.fainted?
      puts "muriooooooo"
      @my_pokemon.gain_experience(@bot_pokemon)
      render "increase_stat"
     
    else
      render "train"
    end               
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_pokemon
      @my_pokemon = MyPokemon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_pokemon_params
      params.require(:my_pokemon).permit(:user_id, :pokemon_id, :nickname, :experience, :level)
    end

    def create_stats(my_pokemon)
      stat_name = ["hp", "attack", "defense", "special_attack", "special_defense", "speed"]
      indiv_stat = IndivStat.create(my_pokemon: my_pokemon,hp:rand(0..31), attack:rand(0..31), defense:rand(0..31), special_attack:rand(0..31), special_defense:rand(0..31), speed:rand(0..31))
      effort_stat = EffortStat.create(my_pokemon: my_pokemon, hp:0, attack:0, defense:0, special_attack:0, special_defense:0, speed:0)
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
end
