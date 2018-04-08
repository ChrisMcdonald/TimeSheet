# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy hours_by_day hours_by_date_range hours_by_user time_sheets_for_week]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @projects = Project.all.paginate(page: params[:page], per_page: 10).reverse_order
    @project = Project.new
  end

  # GET /projects/1
  def show
    if request.format.js? || request.format.html?
      @time = @project.all_time_sheets.paginate(page: params[:page], per_page: 20)
      @time = @project.time_sheets_for_week(params[:start_date], params[:end_date]).paginate(page: params[:page], per_page: 20) if !params[:start_date].blank? && !params[:end_date].blank?
    else
      @time = @project.all_time_sheets
      @time = @project.time_sheets_for_week(params[:start_date], params[:end_date]) if !params[:start_date].blank? && !params[:end_date].blank?
    end

    @column_chart = @project.hours_by_day
    @chat = @project.hours_by_day
    @total_for_user = @project.total_project_users(@project.all_time_sheets)
    @total = @project.total(@total_for_user)

    respond_to do |format|
      format.html
      format.csv { send_data @time.to_csv }
      format.xlsx # {send_data @time_sheets.to_csv(col_sep: "\t")}
      format.pdf do
        render pdf: 'Invoice', header: { right: '[page] of [topage]' }
      end
      format.js
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.js
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /projects/1
  def update
    respond_to do |format|
      # authorize @project
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  def hours_by_day
    if params[:start_date].blank? && params[:end_date]
      render json: @project.hours_by_date_range(params[:start_date], params[:end_date])
    else
      render json: @project.hours_by_day
    end
  end

  def hours_by_user
    render json: @project.hours_by_user_by_project
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.includes(:roles).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :start_date, :end_date, :customer_id)
  end

  # def user_not_authorized(exception)
  #   policy_name = exception.policy.class.to_s.underscore
  #
  #   flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
  #   redirect_to(request.referrer || root_path)
  # end
end
