# openHPI - Programmieren mit Ruby
# Woche 2 - Uebung 2.3

class Human
    def initialize(name, age)
        @name = name
        @age = age
    end

    def self.adulthood
        18
    end

    def adult?
        @age >= self.class.adulthood
    end

    attr_accessor :name, :age
end

fabian = Human.new "Fabian", 28
puts fabian.name, fabian.age
fabian.adult?