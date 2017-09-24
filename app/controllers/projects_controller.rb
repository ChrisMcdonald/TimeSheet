class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @projects = Project.all.paginate(:page => params[:page], :per_page => 10).reverse_order
    @project = Project.new
  end

  # GET /projects/1
  def show
    @chat = Work.where(project_id: @project.id).group(:date).sum(:hour)
	  @pie_chat = TimeSheet.select(:user_id).group(:user_id).joins(:works).where(works: {project_id: 1}).select(:hour).sum(:hour)
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
    authorize @project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
	end

  def user_not_authorized(exception)
	  policy_name = exception.policy.class.to_s.underscore

	  flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
	  redirect_to(request.referrer || root_path)
  end
end
