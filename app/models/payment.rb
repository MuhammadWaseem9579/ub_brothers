# frozen_string_literal: true

class Payment < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :party

  validates :voucher_no,
            :description,
            :debit,
            :credit,
            :payment_date,
            presence: true, allow_blank: false
end
