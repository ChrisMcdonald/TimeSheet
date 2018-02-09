# frozen_string_literal: true

class Identity < ApplicationRecord
  belongs_to :user
  validates :uid, uniqueness: { message: 'already subscribed for another account' }
  # resourcify
end
