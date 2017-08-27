module FormHelper
	def setup_invoice(invoice)
		invoice.invoice_rows||= InvoiceRow.new
		3.times { invoice.invoice_rows.build }
		invoice
	end
end