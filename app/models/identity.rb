class Identity < ApplicationRecord
  # attr_accessor :image
  belongs_to :user
  validates :uid , uniqueness: {message: "already subscribed for another account"}


end
