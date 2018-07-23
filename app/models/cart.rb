class Cart
  include ActiveModel::Model

  attr_accessor :product_ids, :customer_id

  def initialize(attributes = {})
    super
    @product_ids ||= []
  end

  def self.from_session(session)
    if session[:cart]
      new(session[:cart])
    else
      new
    end
  end

  def products
    product_ids.map do |product_id|
      Product.find(product_id)
    end
  end

  def empty?
    product_ids.none?
  end

  def check_out!
    order = Order.create(
      placed_at: Time.zone.now,
      customer_id: customer_id
    )

    product_ids.each do |product_id|
      LineItem.create(
        order: order,
        product_id: product_id,
        amount: 1
      )
    end
  end
end
