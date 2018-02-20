class User::PayObligation < ApplicationRecord
  belongs_to :user
  resourcify
end
