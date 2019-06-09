# frozen_string_literal: true

class Invoice < ApplicationRecord
  resourcify
  include Calculate
  belongs_to :user
  has_many :time_sheets #,  inverse_of: :invoice
  accepts_nested_attributes_for :time_sheets
  belongs_to :project , dependent: :destroy
  validates_presence_of :time_sheets

  def save_invoice(project_id)
    time_sheets = TimeSheet.uninvoiced_work(project_id)
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
                          invoice_date: Date.today)
    invoice.time_sheets << time_sheets

    invoice
  end

  def owner_full_name
    first = if self.owner_first_name
              self.owner_first_name
            else
              'No First Name'
            end

    last = if self.owner_last_name
             self.owner_last_name
           else
             'No Last Name'
           end
    first + ' ' + last
  end

  def customer_full_name
    first = if customer_first_name
              customer_first_name
            else
              'No First Name'
            end

    last = if customer_last_name
             customer_last_name
           else
             'No Last Name'
           end
    first + ' ' + last
  end

  def owner_address
    address = "#{self.owner_street_no}   #{self.owner_street}<br>#{self.owner_city}  #{self.owner_state}  <br>	#{self.owner_country} #{self.owner_post_code}".html_safe
  end

  def customer_address
    address = "#{self.customer_street_no}   #{self.customer_street}<br>#{self.customer_city}  #{self.customer_state}  <br>	#{self.customer_country} #{self.customer_post_code}".html_safe
  end

  def total_for_user
    total = []
    time_sheets = self.time_sheets.includes(:user)
    time_sheets.each do |timesheet|
      total << timesheet.user.rate(timesheet.date) * timesheet.hour
    end
    total
  end

  def invoice_total(row_totals)
    row_totals.inject(0) { |sum, x| sum + x }
  end
end
