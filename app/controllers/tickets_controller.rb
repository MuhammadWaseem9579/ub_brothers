# frozen_string_literal: true

class TicketsController < ApplicationController
  include ApplicationHelper

  before_action :set_party_and_ticket, only: %i[index new create edit update show refund destroy tickets_pdf]

  def index
    @tickets = @party.tickets.order(created_at: :desc)
    @payments = @party.payments.order(created_at: :desc)
  end

  def new
    @ticket = @party.tickets.build
  end

  def create
    @ticket = @party.tickets.build(ticket_params)
    @ticket.user = current_user

    if @ticket.save
      flash[:success] = 'Ticket created successfully.'
      redirect_to party_tickets_path(@party.id)
    else
      flash[:danger] = @ticket.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @ticket.update(ticket_params)
      flash[:success] = 'Ticket updated successfully.'
      redirect_to party_tickets_path(@party.id)
    else
      flash[:danger] = @ticket.errors.full_messages.join(', ')
      render :edit
    end
  end

  def show; end

  def refund
    if @ticket.update(refunded: true)
      flash[:success] = 'Ticket refunded successfully.'
    else
      flash[:error] = "Failed to refund the ticket. Errors: #{@ticket.errors.full_messages}"
    end

    redirect_to party_tickets_path(@party)
  end

  def tickets_pdf
    logo_path = "#{Rails.root}/app/assets/images/ub_brothers_logo.png"

    pdf = Prawn::Document.new

    # Logo
    pdf.image logo_path, position: :center, width: 75

    # Heading
    pdf.move_down 20
    pdf.text @party.name, size: 16, style: :bold, align: :center

    pdf.move_down 20
    pdf.text 'All Tickets', size: 14, style: :bold
    tickets_data = [['Date', 'Invoice No.', 'Ticket No.', 'Sector', 'Fare', 'Taxes', 'SP', 'KB', 'NET']]

    @party.tickets.order(created_at: :desc).each do |t|
      tickets_data << [
        format_date(t.ticket_date),
        t.invoice_no,
        t.ticket_no,
        t.sector,
        t.fare,
        t.taxes,
        t.sp,
        t.kb,
        t.net_total
      ]
    end

    tickets_data << [
      '',
      '',
      '',
      'Total',
      @party.tickets_fare_total,
      @party.tickets_taxes_total,
      @party.tickets_sp_total,
      @party.tickets_kb_total,
      @party.tickets_net_total
    ]

    pdf.table(tickets_data) do
      row(0).font_style = :bold
      columns(1..6).align = :center
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
      row(-1).font_style = :bold
    end

    pdf.move_down 20
    pdf.text 'All payments', size: 14, style: :bold
    payments_data = [['Payment Date', 'Voucher No.', 'Reference', 'Description', 'Cheque No.', 'Debit', 'Credit']]

    @party.payments.order(created_at: :desc).each do |t|
      payments_data << [
        format_date(t.payment_date),
        t.voucher_no,
        t.reference,
        t.description,
        t.cheque_no,
        t.debit,
        t.credit
      ]
    end

    payments_data << [
      '',
      '',
      '',
      '',
      'Total',
      @party.payments_debit_total,
      @party.payments_credit_total
    ]

    pdf.table(payments_data) do
      row(0).font_style = :bold
      columns(1..6).align = :center
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
      row(-1).font_style = :bold
    end

    pdf.move_down 20
    pdf.text 'Details', size: 14, style: :bold
    payments_data = [
      ['Opening Balance B/F', @party.opening_balance],
      ['Add Sale Invoices', @party.tickets_net_total],
      ['Less Refund Invoices', @party.refunded_tickets_total],
      ['Less Receipts  ', @party.payments_credit_total],
      ['Cheque No.', @party.payments_debit_total],
      ['Net Balance', @party.net_balance]
    ]

    pdf.table(payments_data) do
      columns(1..6).align = :center
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
      row(-1).font_style = :bold
    end

    send_data pdf.render, 
          filename: "#{@party.name}_#{Date.today}.pdf", 
          type: 'application/pdf',
          disposition: 'inline'
  end

  def destroy
    if @ticket.destroy
      flash[:success] = 'Ticket deleted successfully.'
    else
      flash[:error] = "Failed to delete the ticket. Errors: #{@ticket.errors.full_messages}"
    end

    redirect_to party_tickets_path(@party)
  end

  private

  def set_party_and_ticket
    @party = current_user.parties.find(params[:party_id])
    @ticket = @party.tickets.find(params[:id].presence || params[:ticket_id]) if params[:id].present? || params[:ticket_id].present?
  end

  def ticket_params
    params.require(:ticket).permit(
      :ticket_date,
      :name,
      :passport_no,
      :invoice_no,
      :ticket_no,
      :sector,
      :fare,
      :taxes,
      :sp,
      :kb
    )
  end
end
