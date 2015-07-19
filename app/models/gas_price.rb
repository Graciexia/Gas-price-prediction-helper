class GasPrice < ActiveRecord::Base
  belongs_to :city
  belongs_to :gas_grade

  def self.K_update_gas_data(version = 0, versions_remaining = 30)
    # Where is the data we are retrieving?
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

    run_date = Date.parse(gas_data['thisversionrun'])
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
      GasPrice.K_update_gas_data(previous_run_version, versions_remaining)
    end
  end

  def self.my_update_gas_data()
    base_url = 'http://fuelgaugereport.aaa.com/import/display.php?lt=metro&ls='

    File.open('lib/assets/CrawlStates.txt', 'r') do |f|
      f.each_line do |state|
        state_abbr = state.strip
        puts 'Processing state: ' + state_abbr
        url = base_url + state_abbr
        doc = Nokogiri::HTML(open(url))
        # doc = Nokogiri::HTML(File.open('lib/assets/gasdata.html', 'rb'))

        current_date = DateTime.strptime(doc.at_css('br+ em').text[/[0-9]+.*/], '%m/%d/%Y')
        yesterday_date = current_date - 1
        doc.css('h2').each_with_index do |element, metro_area_index|
          metro_area = doc.css('h2')[metro_area_index].text.strip
          [current_date, yesterday_date].each_with_index do |price_date, tr_child_offset|
            ['Regular','Midgrade','Premium'].each_with_index do |grade_name, td_child_offset|
              # get the correct price
              price = doc.css('.metro tr:nth-child(' + (tr_child_offset+1).to_s + ') td:nth-child(' + (td_child_offset+2).to_s + ')')[metro_area_index].text[1..99].to_f
              # now put the data in the DB
              city = City.find_or_create_by(name: metro_area, state: state_abbr)
              gas_grade = GasGrade.find_by(grade_name: grade_name)
              GasPrice.find_or_create_by(date: price_date, gas_price: price, city_id: city.id, gas_grade_id: gas_grade.id)
            end
          end
        end

        # metro_area = doc.css('h2') // be sure to strip text
        # current_prices[:regular] = doc.css('.metro tr:nth-child(1) td:nth-child(2)')
        # current_prices[:midgrade] = doc.css('.metro tr:nth-child(1) td:nth-child(3)')
        # current_prices[:premium] = doc.css('.metro tr:nth-child(1) td:nth-child(4)')
        # yesterday_prices[:regular] = doc.css('.metro tr:nth-child(2) td:nth-child(2)')
        # yesterday_prices[:midgrade] = doc.css('.metro tr:nth-child(2) td:nth-child(3)')
        # yesterday_prices[:premium] = doc.css('.metro tr:nth-child(2) td:nth-child(4)')

      end
    end
  end

end
