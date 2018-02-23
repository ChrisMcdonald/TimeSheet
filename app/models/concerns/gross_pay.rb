class GrossPay

  def initialize(pay_o)
    @pay_o = pay_o
  end
  def calculate
    superannuation = @pay_o.superannuation / 10
    holiday = @pay_o.holiday / 10
    charge_out_rate = @pay_o.hourly_rate
    charge_out_rate +=   charge_out_rate * holiday
    charge_out_rate +=   charge_out_rate * superannuation
    charge_out_rate
  end
end