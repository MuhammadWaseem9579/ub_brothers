# frozen_string_literal: true

class Ticket < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :party

  validates :invoice_no,
            :name,
            :passport_no,
            :ticket_no,
            :sector,
            :fare,
            :taxes,
            :sp,
            :kb,
            presence: true, allow_blank: false

  scope :refunded, -> { where(refunded: true) }

  def net_total
    [fare + taxes + sp + kb].compact.sum
  end
end
