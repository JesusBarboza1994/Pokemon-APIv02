class PokemonsController < ApplicationController
  before_action :set_pokemon, only: %i[ show edit update destroy ]

  # GET /pokemons
  def index
    @pokemons = Pokemon.all
  end

  # GET /pokemons/1
  def show
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
  end

  # GET /pokemons/1/edit
  def edit
  end

  # POST /pokemons
  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      redirect_to @pokemon, notice: "Pokemon was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pokemons/1
  def update
    if @pokemon.update(pokemon_params)
      redirect_to @pokemon, notice: "Pokemon was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /pokemons/1
  def destroy
    @pokemon.destroy
    redirect_to pokemons_url, notice: "Pokemon was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pokemon_params
      params.require(:pokemon).permit(:name, :weight, :height, :image)
    end
end
