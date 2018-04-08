# frozen_string_literal: true

class TravelsController < ApplicationController
  before_action :set_travel, only: %i[edit update destroy]
  load_and_authorize_resource

  # GET /travels
  # GET /travels.json
  def index
    @time_sheet = TimeSheet.find(params[:time_sheet_id  ])
    @travels = @time_sheet.travels
  end

  # GET /travels/1
  # GET /travels/1.json
  def show; end

  # GET /travels/new
  def new
    @travel = Travel.new
    @time_sheet = TimeSheet.find(params[:time_sheet_id])
  end

  # GET /travels/1/edit
  def edit
  end

  # POST /travels
  # POST /travels.json
  def create
    @travel = Travel.new(travel_params)
    @travel.time_sheet = TimeSheet.find(travel_params[:time_sheet_id])


    respond_to do |format|
      if @travel.save
        format.html { redirect_to time_sheet_travels_path @travel.time_sheet_id, @travel, notice: 'Travel was successfully created.'}
        format.json { render :show, status: :created, location: @travel }
      else
        format.html { redirect_back( fallback_location: time_sheet_travels_path) }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travels/1
  # PATCH/PUT /travels/1.json
  def update
    respond_to do |format|
      if @travel.update(travel_params)
        format.html { redirect_to @travel, notice: 'Travel was successfully updated.' }
        format.json { render :show, status: :ok, location: @travel }
      else
        format.html { render :edit }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travels/1
  # DELETE /travels/1.json
  def destroy
    @travel.destroy
    respond_to do |format|
      format.html { redirect_to travels_url, notice: 'Travel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_travel
    Travel.includes(:roles).find(params[:id]) || Travel.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def travel_params
    params.require(:travel).permit(:travel_date, :vehicle_id, :od_start, :od_finish, :purpose, :user_id, :project_id, :time_sheet_id)
  end
end
