class TicketsController < ApplicationController
  def index
    @tickets = current_user.parties.find(params[:party_id]).tickets
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.parties.find(params[:party_id]).tickets.build(ticket_params)
    @ticket.user = current_user

    if @ticket.save
      flash[:success] = "Ticket created successfully."
      redirect_to party_tickets_path
    else
      flash[:danger] = @ticket.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @ticket = current_user.parties.find(params[:party_id]).tickets.find(params[:id])
  end

  def update
    @ticket = current_user.parties.find(params[:party_id]).tickets.find(params[:id])

    if @ticket.update(ticket_params)
      flash[:success] = "Ticket updated successfully."
      redirect_to party_tickets_path
    else
      flash[:danger] = @ticket.errors.full_messages.join(', ')
      render :edit
    end
  end

  def show
    @ticket = current_user.parties.find(params[:party_id]).tickets.find(params[:id])
  end

  private

  def ticket_params
    params.require(:ticket).permit(
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
