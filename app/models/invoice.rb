class Invoice < ApplicationRecord
	belongs_to :user
	has_many :invoice_rows, inverse_of: :invoice
	accepts_nested_attributes_for :invoice_rows, allow_destroy: true
	# belongs_to :project

	def self.save_invoice(time)
			t = time.first
			works = Work.find_by(time_sheet_id: t.id)
			project = works.project
			customer = project.customer
			time_sheet = TimeSheet.find(t.id)
			owner = project.user
			invoice = Invoice.new(user_id: owner.id,
								  project_id: project.id,
								  owner_first_name: owner.first_name,
								  owner_last_name: owner.last_name,
								  owner_email: owner.email,
								  owner_street_no: owner.street_no,
								  owner_street: owner.street,
								  owner_city: owner.city,
								  owner_country: owner.country,
								  owner_post_code: owner.post_code,
								  owner_abn: owner.abn,
								  customer_first_name: customer.first_name,
								  customer_last_name: customer.last_name,
								  customer_street_no: customer.street_no,
								  customer_street: customer.street,
								  customer_city: customer.city,
								  customer_country: customer.country,
								  customer_post_code: customer.post_code,
								  customer_abn: customer.abn,


									)
			invoice.save!
		end
	end

