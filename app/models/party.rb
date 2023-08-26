class Party < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, allow_blank: false
end
