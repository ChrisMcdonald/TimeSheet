class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :identities, dependent: :destroy
  has_many :invoices, dependent: :destroy
	validates_presence_of :email ,:first_name, :last_name,

  def self.from_omniauth(auth, current_user)

    identity = Identity.find_or_initialize_by(provider: auth.provider,
                                              uid: auth.uid.to_s,

    )
    identity.token = auth.credentials.token
    identity.username = auth.info.name
    identity.image = auth.info.image
    identity.email = auth.info.email
	# identity.user.avatar = auth.info.image
    identity.save



    if identity.user.blank?
      user = current_user
      identity.user = user
      identity.save

    end

    identity
  end
  def bar
    puts 'class method'
  end

  def user_image
    self.identities.first.image
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
end
