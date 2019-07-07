# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def user_permission
    @user = User.find(params[:user_id])
    if params['commit'] == 'Save'
      User::PERMISSION_GROUPS.each do |value|
        permission = value.split('_').to_a
        if params.include?(value)
          user_roles = @user.roles.select(:id, :name, :resource_type).find_by(resource_type: permission[0], name: permission[1])
          @user.add_role permission[1], permission[0].classify.constantize
        else
          if params[value].blank?
            @user.remove_role permission[1], permission[0].classify.constantize

          end
        end
        array = Array(@user.roles.select(:id, :name, :resource_type).find_by(resource_type: permission[0], name: permission[1])) & Array(user_roles)
        flash[:notice] = " #{@user.full_name}'s permissions have been updated"
      end
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def user_income
    @user = User.find(params[:user_id])

    if request.format.js? || request.format.html?
      @user_table = @user.time_sheets.paginate(page: params[:page], per_page: 20)
      @user_table = @user_table.where(project_id: params[:project_search]) unless params[:project_search].blank?
      @user_table = @user_table.filter_buy_date params[:start_date], params[:end_date] unless params[:start_date].blank? || params[:end_date].blank?
      @sub_total = @user.sub_total(@user.time_sheets)
    else
      @user_table = @user.time_sheets
      @user_table = @user_table.where(project_id: params[:project_search]) unless params[:project_search].blank?
      @user_table = @user_table.filter_buy_date params[:start_date], params[:end_date] unless params[:start_date].blank? || params[:end_date].blank?
      @sub_total = @user.sub_total(@user.time_sheets)
    end

    respond_to do |format|
      format.csv {send_data @user.to_csv(@user_table), disposition: 'attachment;', filename: "#{@user.full_name}-#{Date.today}.csv"}
      format.xlsx {headers['Content-Disposition'] = "attachment; filename: #{@user.full_name}-#{Date.today}.xlsx"}
      format.pdf do
        render pdf: 'Invoice', header: {right: '[page] of [topage]'}, filename: "#{@user.full_name}-#{Date.today}.pdf"
      end
      format.js
      format.html
    end
  end

  def user_data
    @user = User.find(params[:user_id])
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all.paginate(page: params[:page], per_page: 10).reverse_order
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def show;
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.add_role(:read, TimeSheet)
        @user.add_role(:edit, TimeSheet)
        @user.success = true
        format.html {redirect_to users_path, notice: 'User was successfully created.'}
        format.json {render :show, status: :created, location: @user}
        format.js
      else
        @user.success = false

        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @user.success = true

        format.html {redirect_to user_path(@user), notice: 'User was successfully updated.'}
      else
        @user.success = false

        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # @user.time_travel.destroy
    # @user.time_work.destroy
    @user.time_sheets.destroy
    @user.travels.destroy
    @user.customers.destroy
    @user.project.destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to users_url, notice: 'User was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.includes(:roles).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :username, :first_name, :last_name, :street_no, :street, :city, :state, :password, :password_confirmation, :success,
                                 :start_date, :end_date, :country, :post_code, :abn, :project_search, pay_rates_attributes: %i[id rate project_id _destroy])
  end
end
