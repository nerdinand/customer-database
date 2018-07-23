class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader

  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items
  has_many :customers, through: :orders

  validates :name, presence: true
  validates :price_cents, presence: true, numericality: true
end
