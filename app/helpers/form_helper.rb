module FormHelper
	def setup_invoice(invoice)
		invoice.invoice_rows.build ||= InvoiceRow.new
		# 1.times { invoice.invoice_rows.build }
		invoice
	end
end