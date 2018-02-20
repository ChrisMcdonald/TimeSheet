class Payg


  def initialize(income)
    @income = income
  end

  def calucate_tax
    tax_amount = case @income
                   when 0..18_200.0
                     0.0
                   when 18_201.0..37_000.0
                     rate_one(@income)
                   when 37_001.0..87_000.0
                     rate_two(@income)
                   when 87_001.0..180_000.0
                     rate_three(@income)
                   else
                     rate_four(@income)
                 end
    tax_amount
  end

  private

  def rate_one(income)
    taxable = income - 18_200.0
    tax = taxable * 0.19
    tax
  end

  def rate_two(income)
    start_amount = 3572.0
    taxable = income - 37_000.0
    taxable_percentage = taxable * 0.325
    tax = start_amount + taxable_percentage
    tax
  end

  def rate_three(income)
    start_amount = 19_822.0
    taxable = income - 87_000.0
    taxable_percentage = taxable * 0.37
    tax = taxable_percentage + start_amount
    tax
  end

  def rate_four(income)
    start_amount = 54_232.0
    taxable = income - 180_000.0
    taxable_percentage = taxable * 0.45
    tax = taxable_percentage + start_amount
    tax
  end
end
