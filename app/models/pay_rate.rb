# frozen_string_literal: true

class PayRate < ApplicationRecord
  # belongs_to :project
  belongs_to :user
  validates_presence_of :rate, message: 'User must have pay rate'
  resourcify
end
