class DaysController < ApplicationController
  before_action :set_day, only: [:show,  :update, :destroy]

  # GET /days
  # GET /days.json
  # def index
  #   @days = Day.all
  # end
  #
  # # GET /days/1
  # # GET /days/1.json
  # def show
  #
  # end
  #
  # # GET /days/new
  # def new
  #   @day = Day.new
  # end

  # GET /days/1/edit
  def edit
    @day = TimeSheet.find_or_create_by(time_period: params[:time_period], user: current_user, project_id: params[:project_id])

    # if @time_sheet.id.nil?
    #   @time_sheet.time_period = params[:time_period]
    #   @time_sheet.user = current_user
    #   @time_sheet.save!
    # end
  end

  # POST /days
  # POST /days.json
  def create
    @day = TimeSheet.new(day_params)

    respond_to do |format|
      if @day.save
        format.html {redirect_to root_path, notice: 'Day was successfully created.'}
        format.json {render :show, status: :created, location: @day}
      else
        format.html {render :new}
        format.json {render json: @day.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /days/1
  # PATCH/PUT /days/1.json
  def update
    respond_to do |format|
      if @day.update(day_params)
        format.html {redirect_to root_path, notice: 'Day was successfully updated.'}
        format.json {render :show, status: :ok, location: @day}
      else
        format.html {render :edit}
        format.json {render json: @day.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /days/1
  # DELETE /days/1.json
  def destroy
    @day.destroy
    respond_to do |format|
      format.html {redirect_to days_url, notice: 'Day was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_day
    @day = TimeSheet.find_or_create_by(time_period: params[:time_period], user: current_user, project_id: params[:project_id])

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def day_params
    # params.fetch(:timesheet, {})
    params.require(:time_sheet).permit(:time_period, :user_id,:description, :hour)
  end
end
