class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	include Calculate
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pay_rates, inverse_of: :user, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :invoices, dependent: :destroy

  accepts_nested_attributes_for :pay_rates, allow_destroy: true
	# validates_uniqueness_of :email ,message: 'Email is already registed'
	# validates_presence_of :email ,:first_name, :last_name

	attr_accessor :project_search

	def to_csv(obj,options={})
		CSV.generate(options) do |csv|
			csv << ['pay', 'Date Worked','project']
			obj.each do |p|
				csv << [p[:pay], p[:date],p[:project]]
			end
		end
	end
	def pay_per_project(project_id)
		user_arr = Array.new
		time_sheet = TimeSheet.joins(works: :project)
						 .select('works.hour',:project_id, :id, :user_id, :time_period)
						 .where(works: {project_id: project_id})
						 .where(user_id: self.id)
		time_sheet.each do |t|
			pay = t.hour * t.user.rate(t.time_period)
			user_arr << { date:t.time_period,pay: pay,project: t.project_id}
		end
		user_arr
	end


  def pay_for_user
	  pararr = Array.new
	  time_sheet = 	TimeSheet.joins(works: :project)
						  .select('works.hour',:project_id, :id, :user_id, :time_period)
						  .where(user_id: self.id)
	  time_sheet.each do |t|
		  pay = t.hour * t.user.rate(t.time_period)
		 pararr << { date:t.time_period,pay: pay,project: t.project_id}
	  end
	  pararr
  end

	def total_pay(arr)

		tot = arr.map {|p| p[:pay]}.sum
		tot.to_i
		tax = tot * 0.20
		superannuation = tot * 0.10
		holidays = tot * 0.10


		pay_details = Hash.new
		pay_details[:total] = tot
		pay_details[:tax] = tax
		pay_details[:superannuation] = superannuation
		pay_details[:holidays] = holidays

		pay_details

	end


  def rate(created_at)
	  rate = 0
	  begin
	  	rate = self.pay_rates.where('created_at <= ?' ,created_at).last.rate
	  rescue
		 rate =  self.pay_rates.last.rate
	  end
	  rate
  end

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

	  address = "#{self.street_no.humanize }   #{self.street}<br>#{self.city.humanize }  #{self.state.humanize }  <br>	#{self.country.humanize } #{self.post_code.humanize  }".html_safe

  end

  # def fetch_details(auth)
  #   self.email = auth.info.email
  #   self.provider = auth.provider
  #   self.uid = auth.uid
  # end
  #
  #   def self.new_with_session(params, session)
  #     if session['devise.user_attributes']
  #       new(session['devise.user_attributes'], without_protection: true) do |user|
  #       user.attributes = params
  #       user.valid?
  #
  #       end
  #     else
  #       super
  #     end
  #   end
  #
  #
  # def email_required?
  #   super && provider.blank?
  # end
  # def password_required?
  #   super && provider.blank?
  # end


  #
  # def self.from_omniauth(auth, current_user)
  #
  #   identity = Identity.find_or_initialize_by(provider: auth.provider,
  #                                             uid: auth.uid.to_s,
  #
  #   )
  #   identity.token = auth.credentials.token
  #   identity.username = auth.info.name
  #   identity.image = auth.info.image
  #   identity.email = auth.info.email
  # # identity.user.avatar = auth.info.image
  #   identity.save
  #
  #
  #
  #   if identity.user.blank?
  #     user = current_user
  #     identity.user = user
  #     identity.save
  #
  #   end
  #
  #   identity
  # end
  # def bar
  #   puts 'class method'
  # end
  #
  # def user_image
  #   self.identities.first.image
  #     end
end
