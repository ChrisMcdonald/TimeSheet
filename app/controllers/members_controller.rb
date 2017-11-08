class MembersController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource
  def index
    @identity = Identity.all
  end

  def show
  end


end
