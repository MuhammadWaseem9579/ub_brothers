# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :set_party_and_ticket, only: %i[index new create edit update show refund destroy]

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
