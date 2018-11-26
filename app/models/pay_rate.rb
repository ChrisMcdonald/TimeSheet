# frozen_string_literal: true

class PayRate < ApplicationRecord
  belongs_to :project , dependent: :destroy
  belongs_to :user , dependent: :destroy
  validates_presence_of :rate, message: 'User must have pay rate'
  resourcify


end
