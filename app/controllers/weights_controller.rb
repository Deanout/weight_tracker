class WeightsController < ApplicationController
  include Weightable

  before_action :set_weight, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /weights or /weights.json
  def index
    @pagy, @weights = pagy(current_user.weights.order(date: :desc))
  end

  def dashboard
    @weights = current_user.weights.where(date: date_range)
    @averages = @weights.group(:date).average(:value)
    respond_to do |format|
      format.html
      format.json { render json: @averages }
    end
  end

  # GET /weights/1 or /weights/1.json
  def show
  end

  # GET /weights/new
  def new
    @weight = Weight.new
  end

  # GET /weights/1/edit
  def edit
  end

  # POST /weights or /weights.json
  def create
    @weight = Weight.new(weight_params.merge(user: current_user))

    respond_to do |format|
      if @weight.save
        format.html { redirect_to weight_url(@weight), notice: "Weight was successfully created." }
        format.json { render :show, status: :created, location: @weight }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weights/1 or /weights/1.json
  def update
    respond_to do |format|
      if @weight.update(weight_params)
        format.html { redirect_to weight_url(@weight), notice: "Weight was successfully updated." }
        format.json { render :show, status: :ok, location: @weight }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weights/1 or /weights/1.json
  def destroy
    @weight.destroy!

    respond_to do |format|
      format.html { redirect_to weights_url, notice: "Weight was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_weight
    @weight = Weight.find(params[:id])
    redirect_to weights_url, notice: "You are not authorized to view this weight." unless @weight.user == current_user

  end

  # Only allow a list of trusted parameters through.
  def weight_params
    params.require(:weight).permit(:value, :date, :unit)
  end
end
