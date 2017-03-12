class GasPrice < ActiveRecord::Base
  belongs_to :city
  belongs_to :gas_grade

  def self.my_update_gas_data
    base_url = 'http://gasprices.aaa.com/?state='
    puts 'Using my_update_gas_data to crawl current and yesterday\'s gas prices.'
    File.open('lib/assets/CrawlStates.txt', 'r') do |f|
      f.each_line do |state|
        state_abbr = state.strip
        url = base_url + state_abbr
        doc = Nokogiri::HTML(open(url))
        # doc = Nokogiri::HTML(File.open('lib/assets/gasdata.html', 'rb'))

        current_date = DateTime.strptime(doc.at_css('.average-price span').text[/[0-9]+\/[0-9]+\/[0-9]+/], '%m/%d/%y')
        yesterday_date = current_date - 1
        doc.css('.accordion-prices h3').each_with_index do |element, metro_area_index|
          metro_area = element.text
# get to mobile prices (current day only)
# doc.css('.accordion-prices .mobil-content')[0].css('table tr')[0].css('td')[1]
          [current_date, yesterday_date].each_with_index do |price_date, tr_child_offset|
            tr_element = element.next_element.css('table')[0].css('tbody tr')[tr_child_offset]
            ['Regular','Midgrade','Premium'].each_with_index do |grade_name, td_child_offset|
              # get the correct price
              # price = doc.css('.metro tr:nth-child(' + (tr_child_offset+1).to_s + ') td:nth-child(' + (td_child_offset+2).to_s + ')')[metro_area_index].text[1..99].to_f
              price = tr_element.css('td')[1 + td_child_offset].text[/[0-9.]+/]
              # now put the data in the DB
              city = City.find_or_create_by(name: metro_area, state: state_abbr)
              gas_grade = GasGrade.find_by(grade_name: grade_name)
              gas_price = GasPrice.find_by(date: price_date, city_id: city.id, gas_grade_id: gas_grade.id)
              if gas_price == nil
                GasPrice.create(date: price_date, gas_price: price, city_id: city.id, gas_grade_id: gas_grade.id)
              end
            end
          end
        end
      end
    end
  end
end
