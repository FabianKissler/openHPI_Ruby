# openHPI - Programming with Ruby
# Inspection during runtime

class Student
    def initialize(name)
        @name = name
    end
end

franz = Student.new("Franz")
franz.class
franz.methods

class Student
    attr_reader :name
end

franz.name
franz.methods

module Teachable
    attr_writer :teacher

    def has_teacher?
        !@teacher.nil?
    end

    alias teacher? has_teacher?
end

# require './teachable.rb'

Teachable

class Student
    include Teachable
end

# franz.methods - old_methods

Student.ancestors

franz.inspect

class Student
    def inspect
        "Student #{name}"
    end
end

franz.inspect

franz

franz.method(:teacher=)
m = franz.method(:teacher=)

m.arity
m.owner
m.source_location