# frozen_string_literal: true

class Vehicle < ApplicationRecord
  has_many :travels , dependent: :destroy

  def self.select_attributes
    result = []
    all.select(:id, :rego_no).each do |p|
      result.append([p.rego_no, p.id, { class: 'dropdown-item overflow-hidden' }])
    end
    result
  end

  def previous
    self.class.where('id < ?', id).last
  end

  def previous_od_finish
    travels&.last&.od_finish #if first.present?
  end
end
