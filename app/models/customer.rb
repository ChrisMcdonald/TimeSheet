class Customer < ApplicationRecord
	belongs_to :user
	has_one :project

	resourcify
	def full_name

		if self.first_name
			first = self.first_name
		else
			first = 'No First Name'
		end

		if self.last_name
			last = self.last_name
		else
			last = 'No Last Name'
		end
		first.humanize  + " "+ last.humanize
	end

	def address

		address = "#{self.street_no.humanize }   #{self.street.humanize }<br>#{self.city.humanize }  #{self.state.humanize }  <br>	#{self.country.humanize } #{self.post_code.humanize  }".html_safe

	end

end
