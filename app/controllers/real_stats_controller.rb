class RealStatsController < ApplicationController
  before_action :set_real_stat, only: %i[ show edit update destroy ]

  # GET /real_stats
  def index
    @real_stats = RealStat.all
  end

  # GET /real_stats/1
  def show
  end

  # GET /real_stats/new
  def new
    @real_stat = RealStat.new
  end

  # GET /real_stats/1/edit
  def edit
  end

  # POST /real_stats
  def create
    @real_stat = RealStat.new(real_stat_params)

    if @real_stat.save
      redirect_to @real_stat, notice: "Real stat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /real_stats/1
  def update
    if @real_stat.update(real_stat_params)
      redirect_to @real_stat, notice: "Real stat was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /real_stats/1
  def destroy
    @real_stat.destroy
    redirect_to real_stats_url, notice: "Real stat was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_real_stat
      @real_stat = RealStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def real_stat_params
      params.require(:real_stat).permit(:hp, :attack, :defense, :special_attack, :special_defense, :speed, :my_pokemon_id)
    end
end
