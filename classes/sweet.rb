class Sweet
    attr_accessor :id, :title, :description, :image, :price

    def to_s
        id + " " + title + " " + description + " " + image + " " + price
    end
end