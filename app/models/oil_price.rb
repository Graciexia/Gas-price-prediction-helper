class OilPrice < ActiveRecord::Base
  def self.update_oil_data
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

    # myfile = File.open("lib/assets/oildata.json", "rb")
    # contents = myfile.read
    # myfile.close
    # oil_data = JSON.parse(contents)

    prices_array = oil_data['results']['collection1']
    prices_array.each do |x|
      get_date = x['Date']
      get_price =x['ClosingPrice'].gsub(/[^\d\.]/,'').to_f
      OilPrice.find_or_create_by(oil_price: get_price, date: get_date)
    end
    puts 'Oil Data updated at ' + Time.now.to_s + "; Kimono pulled this data on #{oil_data['thisversionrun']} (#{oil_data['version']})"
  end

end
