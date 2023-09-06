class TicketsController < ApplicationController
  before_action :set_party_and_ticket, only: [:index, :new, :create, :edit, :update, :show]

  def index
    @tickets = @party.tickets.order(ticket_date: :desc)
    @payments = @party.payments.order(payment_date: :desc)
  end

  def new
    @ticket = @party.tickets.build
  end

  def create
    @ticket = @party.tickets.build(ticket_params)
    @ticket.user = current_user

    if @ticket.save
      flash[:success] = "Ticket created successfully."
      redirect_to party_tickets_path(@party.id)
    else
      flash[:danger] = @ticket.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      flash[:success] = "Ticket updated successfully."
      redirect_to party_tickets_path(@party.id)
    else
      flash[:danger] = @ticket.errors.full_messages.join(', ')
      render :edit
    end
  end

  def show
  end

  private

  def set_party_and_ticket
    @party = current_user.parties.find(params[:party_id])
    @ticket = @party.tickets.find(params[:id]) if params[:id]
  end

  def ticket_params
    params.require(:ticket).permit(
      :ticket_date,
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
