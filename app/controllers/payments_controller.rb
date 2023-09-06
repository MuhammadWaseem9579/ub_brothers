# frozen_string_literal: true

class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
    @payment = current_user.parties.find(params[:party_id]).payments.build(payment_params)
    @payment.user = current_user

    if @payment.save
      flash[:success] = 'Payment created successfully.'
      redirect_to party_tickets_path(params[:party_id])
    else
      flash[:danger] = @payment.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @payment = current_user.parties.find(params[:party_id]).payments.find(params[:id])
  end

  def update
    @payment = current_user.parties.find(params[:party_id]).payments.find(params[:id])

    if @payment.update(payment_params)
      flash[:success] = 'Payment updated successfully.'
      redirect_to party_tickets_path(params[:party_id])
    else
      flash[:danger] = @payment.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def payment_params
    params.require(:payment).permit(
      :voucher_no,
      :reference,
      :description,
      :cheque_no,
      :debit,
      :credit,
      :payment_date
    )
  end
end
