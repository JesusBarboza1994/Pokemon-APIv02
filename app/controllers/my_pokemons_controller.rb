class MyPokemonsController < ApplicationController
  before_action :set_my_pokemon, only: %i[ show edit update destroy ]

  # GET /my_pokemons
  def index
    @my_pokemons = MyPokemon.all
    @my_pokemons = MyPokemon.all
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
    stat_name = ["hp", "attack", "defense", "special_attack", "special_defense", "speed"]
    @my_pokemon = MyPokemon.new(my_pokemon_params)
    indiv_stat = IndivStat.create(my_pokemon: @my_pokemon,hp:rand(0..31), attack:rand(0..31), defense:rand(0..31), special_attack:rand(0..31), special_defense:rand(0..31), speed:rand(0..31))
    effort_stat = EffortStat.create(my_pokemon: @my_pokemon, hp:0, attack:0, defense:0, special_attack:0, special_defense:0, speed:0)
    stats=[]
  stat_name.each.with_index do |stat, i|
   if stat ==  "hp"
    hp = ((@my_pokemon.pokemon.pokemon_stats[i][:base_stat]*2+@my_pokemon.indiv_stat[stat]+@my_pokemon.effort_stat[stat])*@my_pokemon.level/100 + @my_pokemon.level + 10).floor
    stats.push(hp)
   else
    statelse = ((@my_pokemon.pokemon.pokemon_stats[i][:base_stat]*2+@my_pokemon.indiv_stat[stat]+@my_pokemon.effort_stat[stat])*@my_pokemon.level/100 + 5).floor
    stats.push(statelse)
   end
  end 
  RealStat.create(my_pokemon: @my_pokemon, hp:stats[0], attack:stats[1], defense:stats[2], special_attack:stats[3], special_defense:stats[4], speed:stats[5])
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_pokemon
      @my_pokemon = MyPokemon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_pokemon_params
      params.require(:my_pokemon).permit(:user_id, :pokemon_id, :nickname, :experience, :level)
    end
end
