module CustomersHelper
  def format_timestamp(timestamp)
    return if timestamp.nil?

    "#{distance_of_time_in_words(Time.now, timestamp)} ago (#{timestamp.strftime('%d.%m.%Y')})"
  end
end