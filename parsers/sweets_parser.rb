require 'csv'
require 'yaml'
require 'json'

class SweetsParser
    @@sweets_collection = []

    def initialize(url)
        @url = url
    end
    

    def read_and_save()
        html = open(@url)
        doc = Nokogiri::HTML(html)
        doc.css('#productBox .itemProduct').each do |item|
            sweet = Sweet.new()
            sweet.id = item['data-id'].split('_')[1]
            sweet.title = item.css('.itemName a').text
            sweet.price = item.css('.price span').text
            sweet.description = item.css('.shorSetProductCounttdesc').text
            sweet.image = item.css('.itemLink img').first['src']
            @@sweets_collection.push(sweet)
        end
    end

    def save_to_csv(file)
        CSV.open(file, 'w', headers: ['Id', 'Title', 'Description', 'Image', 'Price'], write_headers: true) do |csv|
            @@sweets_collection.each do |sweet|
                csv << [
                    sweet.id, 
                    sweet.title, 
                    sweet.description,
                    sweet.image,
                    sweet.price
                ]
            end
        end
    end

    def save_to_yml(file)
        File.open(file, 'w+') { |f| f.puts @@sweets_collection.to_yaml }
    end

    def save_to_json(file)
        File.open(file, 'w+') { |f| f.puts @@sweets_collection.to_json }
    end

end