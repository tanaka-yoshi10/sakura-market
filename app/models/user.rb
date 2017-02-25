class User < ApplicationRecord
  has_secure_password

  has_one :address, dependent: :destroy
  has_many :orders
  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :email, presence: true

  validates :password, length: { minimum: 4 }, if: :password_presence?
  validates :password_digest, presence: true

  default_value_for :admin_flag, false

  def password_presence?
    password && password.length > 0
  end
end
