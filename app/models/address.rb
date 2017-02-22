class Address < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :zip_code, presence: true
  validates :prefectures, presence: true
  validates :city, presence: true
  validates :address, presence: true
end
