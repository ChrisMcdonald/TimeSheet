class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def user_income
	  @user = User.find(params[:user_id])
	  if params[:project_search]
		  if params[:project_search] == ""
			  @user_table = @user.pay_for_user
			  @total_pay = @user.total_pay(  @user_table )
		  else
			  array = Array.new
			  arr = params[:project_search]
			  arrList = arr.split(" ")
			  arrList.each do |a|
				  array << a
			  end
			  @user_table =  @user.pay_per_project(array)
			  @total_pay = @user.total_pay(  @user_table )
		  end

	  else
		  @user_table = @user.pay_for_user
		  @total_pay = @user.total_pay(  @user_table )
	  end
		  respond_to do |format|
			  format.csv {send_data @user.to_csv(@user_table),  disposition: "attachment;" ,filename: "#{@user.full_name}-#{Date.today}.csv"}
			  format.xlsx# {send_data @time_sheets.to_csv(col_sep: "\t")}
			  format.pdf do
				  render pdf: "Invoice" , header: { right: '[page] of [topage]' }
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
        format.html { redirect_to user_path(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
	  	format.js
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username, :first_name, :last_name, :street_no, :street, :city, :state,
								   :country, :post_code, :abn,:project_search, pay_rates_attributes: [:id, :rate,:project_id, :_destroy])
	end

end
