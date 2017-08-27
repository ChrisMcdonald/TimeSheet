class Invoice < ApplicationRecord
	belongs_to :user
	has_many :invoice_rows, inverse_of: :invoice
	accepts_nested_attributes_for :invoice_rows, allow_destroy: true
	# belongs_to :project
end
