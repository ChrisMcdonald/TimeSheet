# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource only: %i[index show new]
  skip_authorization_check only: %i[edit create]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all.paginate(page: params[:page], per_page: 10).reverse_order
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @row_total = @invoice.total_for_user
    @total = @invoice.invoice_total(@row_total)
    @works = @invoice.works.includes(:time_sheet).order('time_sheets.time_period')
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@invoice.user.full_name} -invoice- #{@invoice.id}", header: {right: '[page] of [topage]'}, page_size: 'A4', dpi: 300
      end
    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    if params[:search]
      @project = Project.find(params[:search])
      @invoice = Invoice.new
      @work = Work.includes(:time_sheet).order('time_sheets.time_period').uninvoiced_work(@project.id)
      @total_for_user = @invoice.total_for_users(@work)
      @total = @invoice.total(@total_for_user)

      respond_to do |format|
        format.js
        format.html
      end

    else
      @project = Project.first
      @work = Work.uninvoiced_work(@project.id)
      @total_for_user = @invoice.total_for_users(@work)
      @total = @invoice.total(@total_for_user)

    end
  end

  # GET /invoices/1/edit
  def edit; end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new
    # @invoice.user = current_user
    @invoice = @invoice.save_invoice(invoice_params[:project])

    respond_to do |format|
      if @invoice.save

        format.html { redirect_to invoice_path(@invoice), notice: 'Invoice was successfully created.' }
        format.js
        format.pdf

      else
        format.html { redirect_to new_invoice_path, notice: 'Invoice is empty so not saved.' }
        end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def send_invoice

    invoice = params[:invoice]
    InvoiceMailer.invoice_email(invoice).deliver_now
    flash[:notice] = 'Invoice  sent!'
    redirect_to invoice_path(invoice)
  end
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    # puts params.to_yaml
    params.require(:invoice).permit(:id, :search, :name, :endOfFortnight, :invoice_id, :project, :search, invoice_rows_attributes: %i[id rate hours project_id created_at update_at])
  end
end
