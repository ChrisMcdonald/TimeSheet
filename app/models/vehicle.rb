class Vehicle < ApplicationRecord
  has_many :travels

  def self.select_attributes
    result = Array.new
    self.all.select(:id, :rego_no).each do |p|
      result.append([p.rego_no, p.id, {class: "dropdown-item overflow-hidden"}])
    end
    result
  end

  def previous
    self.class.where('id < ?', id).last
  end

  def self.previous_od_finish
    self.first.travels.pluck(:od_finish).last
  end
end
