class GasPrice < ActiveRecord::Base
  belongs_to :city
  belongs_to :gas_grade

  def self.update_gas_data(version = 0, versions_remaining = 30)
    # # Where is the data we are retreiving?
    full_url = 'https://www.kimonolabs.com/api/' + (version == 0 ? '' : version.to_s + '/')
    full_url += ENV['kimono_gas_api'].to_s + '?apikey=' + ENV['kimono_apikey'].to_s
    # full_url = 'https://www.kimonolabs.com/api/7ra9kcyg?apikey=BRTtRN28dLPpkNfi55ICIX5XqK4EZmgy'
    uri = URI.parse(full_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    gas_data = JSON.parse(response.body)

    # myfile = File.open("lib/assets/gasdata.json", "rb")
    # contents = myfile.read
    # myfile.close
    # gas_data = JSON.parse(contents)

    run_date = Date.parse(gas_data['thisversionrun']) - 1
    run_version = gas_data['version'].to_i

    gas_grades = GasGrade.all

    prices_array = (gas_data['results'])['MetroGasPrices']
    prices_array.each do |price_group|
      metro_area = price_group['MetroArea'].to_s
      state_abbr = price_group['url'][-2..-1]
      city = City.find_or_create_by(name: metro_area, state: state_abbr)

      gas_grades.each do |gas_grade|
        price = price_group[gas_grade.grade_name].gsub(/[^\d\.]/,'').to_f
        GasPrice.find_or_create_by(
            date: run_date, gas_price: price, city_id: city.id, gas_grade_id: gas_grade.id)
      end
    end
    puts 'Gas Data updated at ' + Time.now.to_s + "; Kimono pulled this data on #{gas_data['thisversionrun']} (#{gas_data['version']})"

    # checked to see if we missed any previous days, and if so, try to get data for them too
    previous_run_date = run_date - 1
    versions_remaining -= 1
    gas_price_count = GasPrice.where(date: previous_run_date).count
    previous_run_version = run_version - 1
    if gas_price_count == 0 && versions_remaining > 0 && previous_run_version > 0
      GasPrice.update_gas_data(previous_run_version, versions_remaining)
    end
  end



end
