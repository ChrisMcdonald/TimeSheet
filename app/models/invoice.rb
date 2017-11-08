class Invoice < ApplicationRecord
	resourcify
	include Calculate
	belongs_to :user
	has_many :works, inverse_of: :invoice
	accepts_nested_attributes_for :works
	belongs_to :project
	validates_presence_of :works
	def save_invoice(project_id)



			work = Work.uninvoiced_work(project_id)
			project = Project.find(project_id)
			customer = project.customer
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
				invoice.works << work



				invoice
	end


	def owner_full_name
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
	def customer_full_name
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
		works = self.works
			works.each do |work|
			total << work.time_sheet.user.rate(work.date) * work.hour
		end
		total
	end
	def invoice_total(row_totals)
		row_totals.inject(0){|sum,x| sum + x }
	end

end

