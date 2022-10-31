class IndivStatsController < ApplicationController
  before_action :set_indiv_stat, only: %i[ show edit update destroy ]

  # GET /indiv_stats
  def index
    @indiv_stats = IndivStat.all
  end

  # GET /indiv_stats/1
  def show
  end

  # GET /indiv_stats/new
  def new
    @indiv_stat = IndivStat.new
  end

  # GET /indiv_stats/1/edit
  def edit
  end

  # POST /indiv_stats
  def create
    @indiv_stat = IndivStat.new(indiv_stat_params)

    if @indiv_stat.save
      redirect_to @indiv_stat, notice: "Indiv stat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /indiv_stats/1
  def update
    if @indiv_stat.update(indiv_stat_params)
      redirect_to @indiv_stat, notice: "Indiv stat was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /indiv_stats/1
  def destroy
    @indiv_stat.destroy
    redirect_to indiv_stats_url, notice: "Indiv stat was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indiv_stat
      @indiv_stat = IndivStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def indiv_stat_params
      params.require(:indiv_stat).permit(:hp, :attack, :defense, :special_attack, :special_defense, :speed, :my_pokemon_id)
    end
end
