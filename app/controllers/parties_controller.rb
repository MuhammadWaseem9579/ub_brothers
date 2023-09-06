# frozen_string_literal: true

class PartiesController < ApplicationController
  before_action :set_party, only: %i[edit update show]

  def index
    @parties = current_user.parties
  end

  def new
    @party = Party.new
  end

  def create
    @party = current_user.parties.build(party_params)

    if @party.save
      flash[:success] = 'Party created successfully.'
      redirect_to parties_path
    else
      flash[:danger] = @party.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @party.update(party_params)
      flash[:success] = 'Party updated successfully.'
      redirect_to parties_path
    else
      flash[:danger] = @party.errors.full_messages.join(', ')
      render :edit
    end
  end

  def show; end

  private

  def set_party
    @party = current_user.parties.find(params[:id])
  end

  def party_params
    params.require(:party).permit(:name, :opening_balance)
  end
end
