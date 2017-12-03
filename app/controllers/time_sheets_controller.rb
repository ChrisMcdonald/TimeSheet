class TimeSheetsController < ApplicationController
  before_action :set_time_sheet, only: [ :show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  # before_action :set_calender, only: :index
  # GET /time_sheets
  # GET /time_sheets.json

  add_breadcrumb "home", :root_path
  add_breadcrumb "my", :time_sheets_path

  def travel
    @time_sheet = TimeSheet.find(params[:time_sheet_id])
    @time_sheet.travels.build if @time_sheet.travels.count < 1
    @time_sheet.user = current_user
    respond_to do |format|
      format.js
      format.html
    end
  end

  def index
  add_breadcrumb "my", :time_sheets_path
  if can? :manage, User
    @time_sheets = TimeSheet.where(user: current_user)
	@user = current_user
  end

  end
  # GET /time_sheets/1
  # GET /time_sheets/1.json
  def show
    if @time_sheet.works.count < 1
      @time_sheet.works.build
    end
  end

  def current_day
	  @time_sheet = TimeSheet.find_or_create_by(time_period: params[:time_period],user: current_user)
	  if @time_sheet.id.nil?
		  @time_sheet.time_period = params[:time_period]
		  @time_sheet.user = current_user
		  @time_sheet.save!
	  end
    redirect_to time_sheet_path(@time_sheet)
  end

  # GET /time_sheets/new
  def new
    @time_sheet = TimeSheet.new
    @time_sheet.works.build
    @time_sheet.user = current_user

  end

  # GET /time_sheets/1/edit
  def edit
	  @user = current_user
    if @time_sheet.works.count < 1
      @time_sheet.works.build
    end
    respond_to do |format|
      format.js
      format.html
    end

  end

  # POST /time_sheets
  # POST /time_sheets.json
  def create
    @time_sheet = TimeSheet.new(time_sheet_params)
    @time_sheet.user = current_user

	respond_to do |format|
      if @time_sheet.save
        format.html { redirect_to time_sheets_path @time_sheet, notice: 'Time sheet was successfully created.' }
        format.json { render :index, status: :created, location: @time_sheet }
	  	format.js
      else
        format.html {render :show}
        format.json { render json: @time_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_sheets/1
  # PATCH/PUT /time_sheets/1.json
  def update
    respond_to do |format|
      if @time_sheet.update(time_sheet_params)
        format.html {redirect_to time_sheets_path @time_sheet, notice: 'Time sheet was successfully updated.'}
        format.json { render :show, status: :ok, location: @time_sheet }
      else
        format.html {render :show}
        format.json { render json: @time_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_sheets/1
  # DELETE /time_sheets/1.json
  def destroy
    @time_sheet.destroy
    respond_to do |format|
      format.html { redirect_to time_sheets_url, notice: 'Time sheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def hours_for_day
		@hours =  TimeSheet.where(date: params[:date]).joins(:works).select(:hour)
	  respond_to do |format|
		  format.js
	  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

  	def set_calender
		config.beginning_of_week = :sunday
		Time.zone = "Australia/Brisbane"

	end

    def set_time_sheet
      @time_sheet = TimeSheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_sheet_params
      params.require(:time_sheet).permit(:time_period, :user_id,
                                         works_attributes: [:id, :date, :hour, :description, :project_id, :time_sheet_id, :_destroy],
                                         travels_attributes: [:id, :travel_date, :od_start, :od_finish, :purpose, :user_id, :project_id, :time_sheet_id, :vehicle_id]
      )

	end
end
