# frozen_string_literal: true

module FormHelper
  def setup_invoice(invoice)
    invoice.invoice_rows ||= InvoiceRow.new
    2.times { invoice.invoice_rows.build }
    invoice
  end

  def setup_time_sheets(time_sheets)
    time_sheets.works ||= Work.new
    7.times { time_sheets.works.build }
    time_sheets
  end

  def add(time_sheets)
    time_sheets.works ||= Work.new
    1.times { time_sheets.works.build }
    time_sheets
  end

  def setup_works(works)
    works.project ||= Project.new
  end
end
