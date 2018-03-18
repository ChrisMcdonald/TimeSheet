class User < ApplicationRecord
  resourcify
  rolify
  include Calculate

  has_many :user_pay_obligations
  has_many :travels
  has_many :time_travel, through: :time_sheets, foreign_key: :user_id, source: :travels
  has_many :projects
  has_many :time_sheets
  has_many :time_work, through: :time_sheets, foreign_key: :user_id, source: :works
  has_many :project_work, through: :projects, foreign_key: :user_id, source: :works
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages, dependent: :destroy
  # has_many :work_pro, through: :projects, source: :works
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pay_rates, inverse_of: :user, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :invoices, dependent: :destroy

  accepts_nested_attributes_for :pay_rates, allow_destroy: true, reject_if: :rate.blank?
  # validates_uniqueness_of :email ,message: 'Email is already registed'
  validates_presence_of :email, :first_name, :last_name

  attr_accessor :project_search, :success, :user_read, :user_edit, :customer_read, :customer_edit,
                :project_read, :project_edit, :TimeSheet_read, :time_sheet_edit, :Invoice_read, :Invoice_edit,
                :User_admin, :start_date, :end_date, :Travel_read, :Travel_edit, :PayObligation_read, :PayObligation_edit

  PERMISSION_GROUPS = %w[User_read User_edit TimeSheet_read TimeSheet_edit Project_read Project_edit
                         Customer_read Customer_edit Invoice_read Invoice_edit User_admin Travel_read Travel_edit
                          User::PayObligation_read User::PayObligation_edit].freeze

  PERMISSIONS = %w[Travel User TimeSheet Project Customer Invoice User::PayObligation].freeze

  def self.select_attributes
    result = []
    self.all.select(:id, :first_name, :last_name).each do |p|
      result.append([p.full_name, p.id, {class: 'dropdown-item overflow-hidden'}])
    end
    result
  end


  def avatar
    if identities.present?
      identities.first.image
    else
      ActionController::Base.helpers.asset_path('default_avatar.jpeg')
    end
  end

  def to_csv(obj, options = {})
    sub_total = self.sub_total(obj)
    CSV.generate(options) do |csv|
      csv << ['pay', 'hours', 'rate', 'Date Worked', 'project']
      obj.each_with_index do |p, i|
        csv << [sub_total[:sub_totals][i],
                p.hour,
                rate(p.time_sheet.time_period),
                p.time_sheet.time_period.strftime('%A %b %d '),
                p.project.name]
      end
    end
  end

  def pay_per_project(project_id)
    # self.works.find_by project_id: project_id
    project_work.find_by project_id: project_id
  end

  def project
    project_work
  end

  def pay_for_user
    time_work
  end

  def sub_total(time)
    totals = []
    total = 0
    time.each do |t|
      rate = self.rate(t.time_sheet.time_period.to_date)
      sub_total = rate * t.hour
      totals << sub_total
      total += sub_total
    end
    totals
    tax = total * 0.20
    superannuation = total * 0.10
    pay_details = {}
    pay_details[:total] = total
    pay_details[:sub_totals] = totals
    pay_details[:tax] = tax
    pay_details[:superannuation] = superannuation
    pay_details
  end

  def rate(created_at)
    rate = 0
    begin
      rate = pay_rates.where('created_at <= ?', created_at).last.rate
    rescue StandardError
      rate = pay_rates.last.rate
    end
    rate
  end

  def full_name
    first = if first_name
              first_name
            else
              'No First Name'
            end

    last = if last_name
             last_name
           else
             'No Last Name'
           end
    first + ' ' + last
  end

  def address
    address = "#{street_no}   #{street}<br>#{city}  #{state}  <br>	#{country} #{post_code}".html_safe
  end

  def fetch_details(auth)
    self.email = auth.info.email
    self.provider = auth.provider
    self.uid = auth.uid
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end

  def self.from_omniauth(auth, current_user)
    identity = Identity.find_or_initialize_by(provider: auth.provider,
                                              uid: auth.uid.to_s)
    identity.token = auth.credentials.token
    identity.username = auth.info.name
    identity.image = auth.info.image
    identity.email = auth.info.email
    # identity.user.avatar = auth.info.image
    identity.save!

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
    identities.first.image
  end
end
