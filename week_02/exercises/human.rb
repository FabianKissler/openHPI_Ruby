# openHPI - Programming with Ruby
# Exercise 2.3 - Building classes

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

fabian = Human.new "Fabian", 17
puts fabian.name, fabian.age
puts fabian.adult?
fabian.name="Fabian Kissler"
fabian.age=(28)
puts fabian.name, fabian.age
puts fabian.adult?