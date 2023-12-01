# frozen_string_literal: true

class HajjAndUmrah < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :party

  validates :description,
            :entry_date,
            :voucher_no,
            :visa_rate,
            :makkah_hotel_amount,
            :madina_hotel_amount,
            presence: true, allow_blank: false
end
