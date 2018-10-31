# openHPI - Programming with Ruby
# 2.6 Modify classes

module Enumerable
    def nth(n)
        nary = []
        each_with_index { |item, index|
            nary << item if index % n == n - 1
        }
        nary
    end
end

puts [2, 4, 6, 8, 10, 12].nth(2)
puts (4..12).nth(3)