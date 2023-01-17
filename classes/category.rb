class Category
    attr_accessor :id, :name

    def initialize(id = 0, name = '')
        @id = id
        @name = name
    end

    def to_s
        id + " " + name
    end
end