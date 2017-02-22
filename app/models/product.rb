class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :price, presence: true
end
