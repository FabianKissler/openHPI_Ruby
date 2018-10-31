# openHPI - Programming with Ruby
# 2.7 Classes (interactive)

class Task
    def initialize(text, start_time, end_time = nil, tag: "")
        @text = text
        @start_time = start_time
        @end_time = end_time
        @tag = tag
    end

    attr_reader :text, :tag

    def completed?
        @end_time
    end

    def complete!
        @end_time = Time.now
    end
end

task1 = Task.new("Chaos machen", Time.now)
task1.complete!
task1.completed?

task2 = Task.new("Aufraeumen", Time.now)

class TaskList
    def initialize(tasks = [])
        @tasks = tasks
    end

    def <<(task)
        @tasks << task
        self
    end
end

list = TaskList.new([task1])
list << task2

class TaskList
    include Enumerable

    def each
        @tasks.each { |t| yield t }
    end
end

puts list.count
puts list.select { |t| t.completed? }
list.select(&:completed?)

class TaskList
    def seconds_by_weekday
        select(&:completed?)
            .group_by(&:weekday)
            .transform_values do |tasks|
                tasks.reduce(0) do |sum, t|
                    sum + t.duration
                end
            end
    end
end


class Task
    def weekday
        @start_time.wday
    end

    def duration
        return 0 unless completed?
        (@end_time - @start_time).to_i
    end
end

puts list.seconds_by_weekday