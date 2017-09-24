class Project < ApplicationRecord
	# has_many :invoices

	
	
	def self.select_attributes
		result = Array.new
		Project.all.select(:id,:name).each do |p|

			result.append([p.name,p.id])
		end
		result
	end
end
