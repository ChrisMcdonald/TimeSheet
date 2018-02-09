# frozen_string_literal: true

class UserRole < ApplicationRecord
  belongs_to :users
  belongs_to :role
end
