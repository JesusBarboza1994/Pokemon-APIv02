class EffortStatsController < ApplicationController
  before_action :set_effort_stat, only: %i[ show edit update destroy ]

  # GET /effort_stats
  def index
    @effort_stats = EffortStat.all
  end

  # GET /effort_stats/1
  def show
  end

  # GET /effort_stats/new
  def new
    @effort_stat = EffortStat.new
  end

  # GET /effort_stats/1/edit
  def edit
  end

  # POST /effort_stats
  def create
    @effort_stat = EffortStat.new(effort_stat_params)

    if @effort_stat.save
      redirect_to @effort_stat, notice: "Effort stat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /effort_stats/1
  def update
    if @effort_stat.update(effort_stat_params)
      redirect_to @effort_stat, notice: "Effort stat was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /effort_stats/1
  def destroy
    @effort_stat.destroy
    redirect_to effort_stats_url, notice: "Effort stat was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_effort_stat
      @effort_stat = EffortStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def effort_stat_params
      params.require(:effort_stat).permit(:hp, :attack, :defense, :special_attack, :special_defense, :speed, :my_pokemon_id)
    end
end
