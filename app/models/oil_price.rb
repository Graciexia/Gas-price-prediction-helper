class OilPrice < ActiveRecord::Base
  def self.k_update_oil_data
    # Where is the data we are retreiving?
    full_url = 'https://www.kimonolabs.com/api/' + ENV['kimono_oil_api'].to_s +
        '?apikey=' + ENV['kimono_apikey'].to_s
    full_url = 'https://www.kimonolabs.com/api/7w55f0jm?apikey=BRTtRN28dLPpkNfi55ICIX5XqK4EZmgy'
    uri = URI.parse(full_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    oil_data = JSON.parse(response.body)

    prices_array = oil_data['results']['collection1']
    prices_array.each do |x|
      get_date = x['Date']
      get_price =x['ClosingPrice'].gsub(/[^\d\.]/,'').to_f
      OilPrice.find_or_create_by(oil_price: get_price, date: get_date)
    end
    puts 'Oil Data updated at ' + Time.now.to_s + "; Kimono pulled this data on #{oil_data['thisversionrun']} (#{oil_data['version']})"
  end

  def self.my_update_oil_data()
    url = 'http://finance.yahoo.com/q/hp?s=%5EXOI+Historical+Prices'
    puts 'Using my_update_oil_data to crawl all recent oil prices.'
    doc = Nokogiri::HTML(open(url))

    dates_css = doc.css('.yfnc_tabledata1:nth-child(1)')
    closing_prices_css = doc.css('.yfnc_tabledata1:nth-child(5)')
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
