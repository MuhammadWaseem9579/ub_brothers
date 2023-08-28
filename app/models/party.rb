class Party < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :user
  has_many :tickets, dependent: :destroy

  validates :name, presence: true, allow_blank: false
end
