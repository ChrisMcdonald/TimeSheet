# frozen_string_literal: true
require 'will_paginate/array'
require 'net/http'
require 'github'
require 'uri'

class SocialInfoController < ApplicationController
  before_action :authenticate_user!

  def index
    @project = Project.find(params[:project]) if params[:project].present?

    options = {}
    options[:branch] = params[:branch] if params[:branch].present?
    options[:token] = current_user.identities.find_by(provider: 'github').token rescue nil
    @github = Github.new(@project.gitname, options[:branch], options)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@project.gitname}", header: {right: '[page] of [topage]'}, page_size: 'A4', dpi: 300
      end
    end
  end
end
