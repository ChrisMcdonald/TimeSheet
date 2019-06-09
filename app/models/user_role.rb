# frozen_string_literal: true

class UserRole < ApplicationRecord
  belongs_to :user , dependent: :destroy
  belongs_to :role , dependent: :destroy
end
