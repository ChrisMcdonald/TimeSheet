class DaysController < ApplicationController
  before_action :set_day, only: [:show,  :update, :destroy]

  # GET /days
  # GET /days.json
  def index
    @time_sheet = TimeSheet.find_or_initialize_by(time_period: params[:time_period], user: current_user, project_id: params[:project_id])
  end

end
