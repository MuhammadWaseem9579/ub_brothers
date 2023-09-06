# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :parties, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :payments, dependent: :destroy

  def full_name
    return 'Test User' if first_name.blank? && last_name.blank?

    "#{first_name} #{last_name}".strip
  end

  def profile_image_url
    ActionController::Base.helpers.asset_url('avatar.svg')
  end
end
