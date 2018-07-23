module ApplicationHelper
  def formatted_price_with_currency(price_cents)
    number_to_currency(price_cents / 100.0, unit: 'CHF', delimiter: "'", format: '%n %u')
  end
end
