# frozen_string_literal: true

class Party < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  has_many :tickets, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, presence: true, allow_blank: false

  def tickets_fare_total
    @tickets_fare_total ||= tickets.sum(:fare).to_f
  end

  def tickets_taxes_total
    @tickets_taxes_total ||= tickets.sum(:taxes).to_f
  end

  def tickets_sp_total
    @tickets_sp_total ||= tickets.sum(:sp).to_f
  end

  def tickets_kb_total
    @tickets_kb_total ||= tickets.sum(:kb).to_f
  end

  def tickets_net_total
    @tickets_net_total ||= tickets.sum('fare + taxes + sp + kb').to_f
  end

  def refunded_tickets_total
    @refunded_tickets_total ||= tickets.refunded.sum('fare + taxes + sp + kb').to_f
  end

  def payments_debit_total
    @payments_debit_total ||= payments.sum(:debit).to_f
  end

  def payments_credit_total
    @payments_credit_total ||= payments.sum(:credit).to_f
  end

  def net_balance
    @net_balance ||= opening_balance + (
        tickets_net_total - refunded_tickets_total - payments_credit_total
      ) + payments_debit_total
  end
end
