class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	load_and_authorize_resource

	def user_permission
		@user = User.find(params[:user_id])
		if params["commit"] == 'Save'
			User::PERMISSION_GROUPS.each do |value|
				permission = value.split('_').to_a
				if params.include?(value)
					@user.add_role permission[1], permission[0].classify.constantize
				else
					if params[value].blank?
						@user.remove_role permission[1], permission[0].classify.constantize
					end
				end
			end
		end
		respond_to do |format|
			format.js
			format.html
		end
	end

	def user_income
		@user = User.find(params[:user_id])
		@user_table = @user.time_work.paginate(:page => params[:page], :per_page => 20)
		@user_table = @user_table.where(project_id: params[:project_search]) if params[:project_search]
		@user_table = @user_table.where(time_sheet: {time_period: Date.yesterday..Date.tomorrow}) if params[:start_date] && params[:end_date]
		@sub_total = @user.sub_total(@user.time_work)

		respond_to do |format|
			format.csv {send_data @user.to_csv(@user_table), disposition: "attachment;", filename: "#{@user.full_name}-#{Date.today}.csv"}
			format.xlsx # {send_data @time_sheets.to_csv(col_sep: "\t")}
			format.pdf do
				render pdf: "Invoice", header: {right: '[page] of [topage]'}
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
		@users = User.all.paginate(:page => params[:page], :per_page => 10).reverse_order
		@user = User.new
	end

	# GET /users/1
	# GET /users/1.json
	def show


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
				format.json {render :show, status: :ok, location: @user}
				format.js
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
		@user.destroy
		respond_to do |format|
			format.html {redirect_to users_url, notice: 'User was successfully destroyed.'}
			format.json {head :no_content}
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:email, :username, :first_name, :last_name, :street_no, :street, :city, :state, :password, :password_confirmation, :success,
									 :country, :post_code, :abn, :project_search, pay_rates_attributes: [:id, :rate, :project_id, :_destroy])
	end

end
