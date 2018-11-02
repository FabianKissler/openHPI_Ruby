# openHPI - Programming with Ruby
# 2.10 Our first program (interactive)

require "time"

class Task
    def self.parse(line)
        parts = line.split ","
        new(
            parts[0],
            Time.parse(parts[1]),
            (Time.parse(parts[2]) rescue nil),
            tag: parts[4]
        )
    end

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

class Task
    def weekday
        @start_time.wday
    end

    def duration
        return 0 unless completed?
        (@end_time - @start_time).to_i
    end

    def to_s
        "#{@text},#{@start_time},#{@end_time},#{@tag}
        \n"
    end
end

class TaskList
    def self.from_file(filename)
        instance = new
        instance.load filename
        instance
    end

    def initialize(tasks = [])
        @tasks = tasks
    end

    def load(filename)
        File.open(filename, "r") do |file|
            file.each do |line|
                self << Task.parse(line)
            end
        end
    end

    def save(filename)
        File.write(
            filename,
            map(&:to_s).join
        )
    end

    def <<(task)
        @tasks << task
        self
    end
end

class TaskList
    include Enumerable

    def each
        @tasks.each { |t| yield t }
    end
end

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

def add_task(title)
    list = TaskList.from_file "tasks.txt"
    list << Task.new(title, Time.now)
    list.save "tasks.txt"
end

case ARGV.shift
when "add"
    add_task ARGV.first
end