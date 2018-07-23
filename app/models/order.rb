class Order < ApplicationRecord
  belongs_to :customer
  has_many :line_items

  def price_cents
    line_items.sum do |line_item|
      line_item.price_cents
    end
  end
end