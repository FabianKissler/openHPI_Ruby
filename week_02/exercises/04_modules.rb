# openHPI - Programming with Ruby
# 2.4 Modules

class Task
    attr_accessor :title    
    
    include Comparable
    
    def initialize(title)
        @title = title
    end

    #Compare by lowercase name
    def <=>(other)
        title.downcase <=> other.title.downcase
    end
end

Task.new("Learn Ruby").respond_to? :between?
task1 = Task.new("Learn Ruby") 
task2 = Task.new("get certificate")

puts task1 > task2