class StatsController < ApplicationController
  before_action :set_stat, only: %i[ show edit update destroy ]

  # GET /stats
  def index
    @stats = Stat.all
  end

  # GET /stats/1
  def show
  end

  # GET /stats/new
  def new
    @stat = Stat.new
  end

  # GET /stats/1/edit
  def edit
  end

  # POST /stats
  def create
    @stat = Stat.new(stat_params)

    if @stat.save
      redirect_to @stat, notice: "Stat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stats/1
  def update
    if @stat.update(stat_params)
      redirect_to @stat, notice: "Stat was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /stats/1
  def destroy
    @stat.destroy
    redirect_to stats_url, notice: "Stat was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat
      @stat = Stat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stat_params
      params.require(:stat).permit(:name)
    end
end
