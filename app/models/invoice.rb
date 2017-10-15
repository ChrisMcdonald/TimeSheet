class Invoice < ApplicationRecord
	belongs_to :user
	has_many :invoice_rows, inverse_of: :invoice
	accepts_nested_attributes_for :invoice_rows, allow_destroy: true
	# belongs_to :project

	def self.save_invoice(time)
			time_time_sheet_var = time.first
			works = Work.find_by(time_sheet_id: time_time_sheet_var.id)
			project = works.project
			customer = project.customer
			time_sheet = TimeSheet.find(time_time_sheet_var.id)
			owner = project.user
			invoice = Invoice.new(user_id: owner.id,
								  project_id: project.id,
								  owner_first_name: owner.first_name,
								  owner_last_name: owner.last_name,
								  owner_email: owner.email,
								  owner_street_no: owner.street_no,
								  owner_street: owner.street,
								  owner_city: owner.city,
								  owner_state: owner.state,
								  owner_country: owner.country,
								  owner_post_code: owner.post_code,
								  owner_abn: owner.abn,
								  customer_first_name: customer.first_name,
								  customer_last_name: customer.last_name,
								  customer_street_no: customer.street_no,
								  customer_street: customer.street,
								  customer_city: customer.city,
								  customer_state: customer.state,
								  customer_country: customer.country,
								  customer_post_code: customer.post_code,
								  customer_abn: customer.abn,
								  invoice_date: Date.today,


									)
			time.each do |time_work_var|
				work = Work.find_by(time_sheet_id: time_work_var.id)
				invoice.invoice_rows << InvoiceRow.new(
											invoice_id: time_work_var.id,
											hours: work.hour,
											date: work.time_sheet.time_period,
											username: work.time_sheet.user.full_name,
											rate: work.time_sheet.user.rate(time_work_var.time_period)
				)

			end


			invoice.save!
	end
	def owner_fullname
		if self.owner_first_name
			first = self.owner_first_name
		else
			first = 'No First Name'
		end

		if self.owner_last_name
			last = self.owner_last_name
		else
			last = 'No Last Name'
		end
		first.humanize  + ' '+ last.humanize
	end
	def customer_fullname
		if self.customer_first_name
			first = self.customer_first_name
		else
			first = 'No First Name'
		end

		if self.customer_last_name
			last = self.customer_last_name
		else
			last = 'No Last Name'
		end
		first.humanize  + ' '+ last.humanize
	end
	def owner_address

		address = "#{self.owner_street_no.humanize }   #{self.owner_street}<br>#{self.owner_city.humanize }  #{self.owner_state.humanize }  <br>	#{self.owner_country.humanize } #{self.owner_post_code.humanize  }".html_safe

	end

	def customer_address

		address = "#{self.customer_street_no.humanize }   #{self.customer_street}<br>#{self.customer_city.humanize }  #{self.customer_state.humanize }  <br>	#{self.customer_country.humanize } #{self.customer_post_code.humanize  }".html_safe

	end
	def total_for_user
		total = Array.new
		i = self.invoice_rows
			i.each do |r|
			total << r.rate * r.hours
		end
		total
	end
	def invoice_total(row_totals)
		row_totals.inject(0){|sum,x| sum + x }
	end

end

