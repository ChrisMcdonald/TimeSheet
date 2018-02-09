# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :user
  has_one :project

  resourcify
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
    first.humanize + ' ' + last.humanize
  end

  def address
    address = "#{street_no.humanize}   #{street.humanize}<br>#{city.humanize}  #{state.humanize}  <br>	#{country.humanize} #{post_code.humanize}".html_safe
  end
end
