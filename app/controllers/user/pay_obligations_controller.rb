# frozen_string_literal: true

class User::PayObligationsController < ApplicationController
  before_action :set_user_pay_obligation, only: %i[show edit update destroy]
  load_and_authorize_resource except: :create

  # GET /users/pay_obligations
  # GET /users/pay_obligations.json
  def index
    @user = User.find(params[:user_id])
    @user_pay_obligations = User::PayObligation.where(user_id: @user.id)
  end

  # GET /users/pay_obligations/1
  # GET /users/pay_obligations/1.json
  def show
    @user = User.find(params[:user_id])
    @gross = GrossPay.new(@user_pay_obligation).calculate
  end

  # GET /users/pay_obligations/new
  def new
    @user_pay_obligation = User::PayObligation.new
  end

  # GET /users/pay_obligations/1/edit
  def edit; end

  # POST /users/pay_obligations
  # POST /users/pay_obligations.json
  def create
    @user_pay_obligations = User::PayObligation.new(user_pay_obligation_params)
    @user_pay_obligations.user = User.find(params[:user_id])

    respond_to do |format|
      if @user_pay_obligations.save
        format.html { redirect_to user_pay_obligation_path(id: @user_pay_obligations.id), notice: 'Pay obligation was successfully created.' }
        format.json { render :show, status: :created, location: @user_pay_obligations }
      else
        format.html { render :new }
        format.json { render json: @user_pay_obligations.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/pay_obligations/1
  # PATCH/PUT /users/pay_obligations/1.json
  def update
    respond_to do |format|
      if @user_pay_obligation.update(user_pay_obligation_params)
        format.html { redirect_to user_pay_obligation_path(user_id: @user_pay_obligation.user_id, id: @user_pay_obligation.id), notice: 'Pay obligation was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_pay_obligation }
      else
        format.html { render :edit }
        format.json { render json: @user_pay_obligation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/pay_obligations/1
  # DELETE /users/pay_obligations/1.json
  def destroy
    @user_pay_obligation.destroy
    respond_to do |format|
      format.html { redirect_to user_pay_obligations_path, notice: 'Pay obligation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_pay_obligation
    @user_pay_obligation = User::PayObligation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_pay_obligation_params
    params.require(:user_pay_obligation).permit(:id, :superannuation, :holiday, :hourly_rate, :user_id)
  end
end
