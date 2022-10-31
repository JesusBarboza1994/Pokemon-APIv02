class PokemonStatsController < ApplicationController
  before_action :set_pokemon_stat, only: %i[ show edit update destroy ]

  # GET /pokemon_stats
  def index
    @pokemon_stats = PokemonStat.all
  end

  # GET /pokemon_stats/1
  def show
  end

  # GET /pokemon_stats/new
  def new
    @pokemon_stat = PokemonStat.new
  end

  # GET /pokemon_stats/1/edit
  def edit
  end

  # POST /pokemon_stats
  def create
    @pokemon_stat = PokemonStat.new(pokemon_stat_params)

    if @pokemon_stat.save
      redirect_to @pokemon_stat, notice: "Pokemon stat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pokemon_stats/1
  def update
    if @pokemon_stat.update(pokemon_stat_params)
      redirect_to @pokemon_stat, notice: "Pokemon stat was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /pokemon_stats/1
  def destroy
    @pokemon_stat.destroy
    redirect_to pokemon_stats_url, notice: "Pokemon stat was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_stat
      @pokemon_stat = PokemonStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pokemon_stat_params
      params.require(:pokemon_stat).permit(:stat_id, :pokemon_id, :base_stat, :effort)
    end
end
