class OilPrice < ActiveRecord::Base
  def self.my_update_oil_data
    puts 'Using my_update_oil_data to crawl all recent oil prices.'

    # Google oil price URL - simple method
    url = 'https://www.google.com/finance/historical?q=INDEXNYSEGIS%3AXOI&start=0&num=200'
    doc = Nokogiri::HTML(open(url))

    dates_css = doc.css('td.lm')
    closing_prices_css = doc.css('td:nth-child(5)')
    count = closing_prices_css.count
    (0...count).each do |index|
      get_price = closing_prices_css[index].text.gsub(/[^\d\.]/,'').to_f
      get_date = dates_css[index].text
      OilPrice.find_or_create_by(oil_price: get_price, date: get_date)
    end

  end

  def self.my_update_gusbbudy_data
    url = 'http://www.gasbuddy.com/'
    puts "using my_update_gusbbudy_data"
    doc = Nokogiri::HTML(open(ulr))
  end
end
