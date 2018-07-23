class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def price_cents
    product.price_cents * amount
  end
end