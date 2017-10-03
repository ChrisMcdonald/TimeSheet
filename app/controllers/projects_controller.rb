class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy,:hours_by_day,:hours_by_user,:time_sheets_for_week]
  before_action :authenticate_user!

  def index
    @projects = Project.all.paginate(:page => params[:page], :per_page => 10).reverse_order
    @project = Project.new
  end

	# GET /projects/1
	def show
		# @chat = @project.hours_by_day
		if params[:start_date] && params[:end_date]
			@time = @project.time_sheets_for_week(params[:start_date], params[:end_date])
		else
			@time =@project.all_time_sheets
		end
		respond_to do |format|
			format.html
			format.csv {send_data @time.to_csv}
			format.xls # {send_data @time_sheets.to_csv(col_sep: "\t")}
			format.js
		end

	end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    # @project.user = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project), notice: 'Project was successfully created.' }
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
	  render json: @project.hours_by_day
  end
  def hours_by_user
	  render json: @project.hours_by_user_by_project
  end


  private



    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name,:start_date, :end_date)
	end

  # def user_not_authorized(exception)
	#   policy_name = exception.policy.class.to_s.underscore
  #
	#   flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
	#   redirect_to(request.referrer || root_path)
  # end
end
