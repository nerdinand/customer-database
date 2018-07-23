require 'faker'
require 'net/http'
require 'tempfile'

Faker::Config.locale = 'de-CH'

def download_lorem_flickr
  http = Net::HTTP.new('loremflickr.com', 443)
  http.use_ssl = true
  
  loremflickr_uri = URI(Faker::LoremFlickr.image('300x300', ['products'])).path

  image_uri = http.get(loremflickr_uri)['location']
  response = http.get(image_uri)

  file = Tempfile.new(['image', '.jpg'], encoding: 'ascii-8bit')
  file.write(response.body)
  file
end

ActiveRecord::Base.connection.transaction do
  10.times do
    Customer.create!(
      name: Faker::Company.name,
      address: Faker::Address.street_address,
      zip_code: Faker::Address.zip_code,
      city: Faker::Address.city,
      phone_number: Faker::PhoneNumber.phone_number
    )
  end

  20.times do
    product_image_file = download_lorem_flickr

    begin
      Product.create!(
        name: Faker::Lorem.words(2, true).join(' '),
        description: Faker::Lorem.paragraph(2, true, 2),
        image: product_image_file,
        price_cents: Faker::Number.between(10_00, 10000_00)
      )
    ensure
      product_image_file.unlink
    end
  end

  Customer.all.each do |customer|
    Faker::Number.between(1, 10).times do
      has_been_paid = Faker::Boolean.boolean
      has_been_delivered = has_been_paid && Faker::Boolean.boolean

      placed_at = Faker::Time.between(2.years.ago, Date.today)
      paid_at = has_been_paid ? Faker::Time.between(placed_at, placed_at + 1.month) : nil
      delivered_at = has_been_delivered ? Faker::Time.between(paid_at, paid_at + 1.month) : nil

      order = Order.create!(
        customer: customer,
        placed_at: placed_at,
        paid_at: paid_at,
        delivered_at: delivered_at
      )

      Faker::Number.between(1, 10).times do
        LineItem.create!(
          order: order,
          product: Product.all.sample,
          amount: Faker::Number.between(1, 10)
        )
      end
    end
  end
end
