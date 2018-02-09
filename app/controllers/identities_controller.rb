# frozen_string_literal: true

class IdentitiesController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_identity, only: %i[index show edit update destroy]
  before_action :authenticate_user!
  # load_and_authorize_resource
  # GET /identities
  # GET /identities.json
  def index
    @identities = Identity.where("user_id = '?'", current_user.id)
  end

  # GET /identities/1
  # GET /identities/1.json
  def show; end

  # GET /identities/new
  def new
    @user = User.from_omniauth(request.env['omniauth.auth'], current_user)
  end

  # GET /identities/1/edit
  def edit; end

  # POST /identities
  # POST /identities.json
  def create
    @identity = Identity.new(identity_params)

    respond_to do |format|
      if @identity.save
        format.html { redirect_to @identity, notice: 'Identity was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /identities/1
  # PATCH/PUT /identities/1.json
  def update
    respond_to do |format|
      if @identity.update(identity_params)
        format.html { redirect_to @identity, notice: 'Identity was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /identities/1
  # DELETE /identities/1.json
  def destroy
    @identity.destroy
    respond_to do |format|
      format.html { redirect_to identities_url, notice: 'Identity was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_identity
    @identity = Identity.find_by(user_id: current_user)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def identity_params
    params.require(:identity).permit(:provider, :username, :image, :user_id)
  end
end
