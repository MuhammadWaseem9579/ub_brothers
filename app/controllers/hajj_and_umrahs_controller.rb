# frozen_string_literal: true

class HajjAndUmrahsController < ApplicationController
  before_action :set_party_and_hajj_and_umrah, only: %i[index new create edit update show refund destroy]

  def index
    @hajj_and_umrahs = @party.hajj_and_umrahs.order(created_at: :desc)
  end

  def new
    @hajj_and_umrah = @party.hajj_and_umrahs.build
  end

  def create
    @hajj_and_umrah = @party.hajj_and_umrahs.build(hajj_and_umrah_params)
    @hajj_and_umrah.user = current_user

    if @hajj_and_umrah.save
      flash[:success] = 'Hajj and Umrah created successfully.'
      redirect_to party_hajj_and_umrahs_path(@party.id)
    else
      flash[:danger] = @hajj_and_umrah.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @hajj_and_umrah.update(hajj_and_umrah_params)
      flash[:success] = 'Hajj and Umrah updated successfully.'
      redirect_to party_hajj_and_umrahs_path(@party.id)
    else
      flash[:danger] = @hajj_and_umrah.errors.full_messages.join(', ')
      render :edit
    end
  end

  def show; end

  def refund
    if @hajj_and_umrah.update(refunded: true)
      flash[:success] = 'Hajj and Umrah refunded successfully.'
    else
      flash[:error] = "Failed to refund the ticket. Errors: #{@hajj_and_umrah.errors.full_messages}"
    end

    redirect_to party_hajj_and_umrahs_path(@party)
  end

  def destroy
    if @hajj_and_umrah.destroy
      flash[:success] = 'Hajj and Umrah deleted successfully.'
    else
      flash[:error] = "Failed to delete the ticket. Errors: #{@hajj_and_umrah.errors.full_messages}"
    end

    redirect_to party_hajj_and_umrahs_path(@party)
  end

  private

  def set_party_and_hajj_and_umrah
    @party = current_user.parties.find(params[:party_id])
    @hajj_and_umrah = @party.hajj_and_umrahs.find(params[:id]) if params[:id].present?
  end

  def hajj_and_umrah_params
    params.require(:hajj_and_umrah).permit(
      :description,
      :entry_date,
      :voucher_no,
      :visa_rate,
      :makkah_hotel_amount,
      :madina_hotel_amount
    )
  end
end
