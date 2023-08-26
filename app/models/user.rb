class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :parties

  def full_name
    return 'Test User' if first_name.blank? && last_name.blank?

    "#{first_name} #{last_name}".strip
  end
end
