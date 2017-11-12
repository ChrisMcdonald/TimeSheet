class UserRole < ApplicationRecord
	belongs_to :users
	belongs_to :role
end