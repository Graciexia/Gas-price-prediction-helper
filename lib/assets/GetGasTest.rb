require 'nokogiri'
require 'open-uri'

base_url = 'http://fuelgaugereport.aaa.com/import/display.php?lt=metro&ls='

File.open("CrawlStates.txt", "r") do |f|
  f.each_line do |state|
    url = base_url + state
    # doc = Nokogiri::HTML(open(url))
    doc = Nokogiri::HTML(File.open('gasdata.html', 'rb'))

    current_date = DateTime.strptime(doc.at_css('br+ em').text[/[0-9]+.*/], '%m/%d/%Y')
    yesterday_date = current_date - 1
    doc.css('h2').each_with_index do |element, metro_area_index|
      metro_area = doc.css('h2')[metro_area_index].text.strip
      [current_date, yesterday_date].each_with_index do |price_date, tr_child_offset|
        ['Regular' => 2,'Midgrade' => 3,'Premium' => 4].each_with_index do |grade_name, td_child_offset|
          # get the correct price
          price = doc.css('.metro tr:nth-child(' + (tr_child_offset+1).to_s + ') td:nth-child(' + (td_child_offset+2).to_s + ')')[metro_area_index].text[1..99].to_f
          # now put the data in the DB
          city = City.find_or_create_by(name: metro_area, state: state)
          gas_grade = GasGrade.find_by_grade_name(grade_name)
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


