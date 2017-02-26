class User < ApplicationRecord
  has_secure_password

  DUMMY_PASSWORD = 'DUMMY_PASSWORD'

  has_one :address, dependent: :destroy
  has_many :orders
  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 4 }, allow_nil: false

  default_value_for :admin_flag, false

  def update_profile_only(user_params)
    self.password = DUMMY_PASSWORD
    self.password_confirmation = DUMMY_PASSWORD
    self.attributes=user_params

    if self.valid?
      self.password = ''
      self.password_confirmation = ''
      self.save(validate: false)
    end
  end
end
