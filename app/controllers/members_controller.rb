class MembersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @identity = Identity.all
  end

  def show
  end


end
