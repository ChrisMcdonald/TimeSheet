class InvoiceMailer < ApplicationMailer

  default from: 'chris78323@gmai.com'

  def invoice_email(invoice)

    @invoice = Invoice.find invoice
    @customer = @invoice.project.customer
    @row_total = @invoice.total_for_user
    @total = @invoice.invoice_total(@row_total)
    @works = @invoice.works.includes(:time_sheet).order('time_sheets.time_period')


    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths

    # need these in case your view constructs any links or references any helper methods.
    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end

    pdf_html = av.render template: 'invoices/show.pdf.erb', layout: 'layouts/pdf', locals: {:@invoice => @invoice, :@row_total => @row_total, :@total => @total, :@works => @works}

    # use wicked_pdf gem to create PDF from the doc HTML
    doc_pdf = WickedPdf.new.pdf_from_string(
        pdf_html,
        javascript_delay: 600,
        header: {right: '[page] of [topage]'},
        page_size: 'A4',
        dpi: 300
    )
    #  # save PDF to disk
    pdf_path = Rails.root.join('tmp/reports', "#{@invoice.id}_#{Date.today.iso8601}.pdf")
    File.open(pdf_path, 'wb') do |file|
      file.write doc_pdf
      file.close
    end
    File.open pdf_path


    # The report has now been saved elsewhere using Paperclip; we don't need to store it locally


    attachments["invoice.pdf"] = {mime_type: 'application/pdf', content: File.read(pdf_path)}

    mail(to: @customer.email, subject: "Invoice from #{@customer.user.full_name}")
    File.delete(pdf_path) if File.exist?(pdf_path)
  end
end
