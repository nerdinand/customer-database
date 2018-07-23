class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader

  has_many :line_items
  has_many :orders, through: :line_items
  has_many :customers, through: :orders
end
