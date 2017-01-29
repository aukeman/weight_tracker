class WeightMeasurementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weight_measurement, only: [:update, :destroy]

  # GET /weight_measurements
  def index
    @weight_measurements = WeightMeasurement.where(user: current_user).order(:day).all

    render json: @weight_measurements
  end

  # POST /weight_measurements
  def create
    @weight_measurement = WeightMeasurement.new(weight_measurement_params)

    if @weight_measurement.save
      render json: @weight_measurement, status: :created, location: @weight_measurement
    else
      render json: @weight_measurement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /weight_measurements/1
  def update
    if @weight_measurement.update(weight_measurement_params)
      render json: @weight_measurement
    else
      render json: @weight_measurement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /weight_measurements/1
  def destroy
    @weight_measurement.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight_measurement
      @weight_measurement = WeightMeasurement.find_by(user: current_user, id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def weight_measurement_params
      params.fetch(:weight_measurement).permit(:day, :weight).merge(user: current_user)
    end
end
