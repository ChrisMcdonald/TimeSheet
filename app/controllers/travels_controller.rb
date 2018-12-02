# frozen_string_literal: true

class TravelsController < ApplicationController
  before_action :set_travel, only: %i[edit update destroy]
  load_and_authorize_resource
  layout false

  # GET /travels
  # GET /travels.json
  def index
    # @time_sheet = TimeSheet.find(params[:time_sheet_id  ])
    @travels = Travel.where(user: current_user)
    @travels = @travels.where(travel_date: params[:time_period]) if !params[:time_period].nil?
    travel = Travel.new(travel_date: params[:time_period])
    @travel_date = travel.travel_date
    respond_to do |format|
      format.html
      format.js
    end

  end

  # :layout => false
  # GET /travels/1
  # GET /travels/1.json
  def show; end

  # GET /travels/new
  def new
    @travel = Travel.new
    @vehicle = Vehicle.find params[:vehicle_id]
    # @time_sheet = TimeSheet.find(params[:time_sheet_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /travels/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /travels
  # POST /travels.json
  def create
    @travel = Travel.new(travel_params)
    @travel.vehicle_id = params[:vehicle_id]
    @travel.user = current_user
    @vehicle = @travel.vehicle
    # @travel.time_sheet = TimeSheet.find(travel_params[:time_sheet_id])
    respond_to do |format|
      if @travel.save
        format.html {redirect_to travels_path(time_period: @travel.travel_date, project_id: @travel.project_id), notice: 'Travel was successfully created.'}
        format.json { render :show, status: :created, location: @travel }

        format.js {flash[:notice] = 'Travel was successfully created.'}

      else
        format.html {redirect_to edit_vehicle_travel_path(id: @travel.id, vehicle_id: @travel.vehicle_id)}

        format.json { render json: @travel.errors, status: :unprocessable_entity }
        format.js {render :edit}
      end
    end


  end

  # PATCH/PUT /travels/1
  # PATCH/PUT /travels/1.json
  def update
    respond_to do |format|
      if @travel.update(travel_params)
        format.html {redirect_to travels_path(time_period: @travel.travel_date, project_id: @travel.project_id), notice: 'Travel was successfully updated.'}
        format.json { render :show, status: :ok, location: @travel }
        format.js {flash[:notice] = 'Travel was successfully updated.'}
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
    Travel.find(params[:id]) || Travel.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def travel_params
    params.require(:travel).permit(:travel_date, :od_start, :od_finish, :purpose, :user_id, :project_id)
  end
end
