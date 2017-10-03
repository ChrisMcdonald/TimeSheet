class MembersController < ApplicationController
	before_action :authenticate_user!

  def index
    @identity = Identity.all
  end

  def show
  end


end
