require 'csv'
require 'yaml'

class CategoriesParser
    @@categories_collection = []

    def initialize(url)
        @url = url
    end
    

    def read_and_save()
        html = open(@url)
        doc = Nokogiri::HTML(html)
        doc.css('.wrFilterList .filterItem').each do |item|
            category = Category.new()
            category.id = item['curid']
            category.name = item.text
            @@categories_collection.push(category)
        end
    end

    def save_to_csv(file)
        read_and_save
        CSV.open(file, 'w', headers: ['Id', 'Name'], write_headers: true) do |csv|
            @@categories_collection.each do |category|
                csv << [
                    category.id, 
                    category.name, 
                ]
            end
        end
    end

    def save_to_yml(file)
        read_and_save
        File.open(file, 'w+') { |f| f.puts @@categories_collection.to_yaml }
    end

    def save_to_json(file)
        read_and_save
        File.open(file, 'w+') { |f| f.puts @@categories_collection.to_json }
    end

end