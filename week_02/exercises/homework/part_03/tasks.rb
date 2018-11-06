# Für Time.parse
require "time"


class Task
  def initialize(text, start_time, end_time = nil)
    @text = text
    @start_time = start_time
    @end_time = end_time
  end

  def self.parse(line)
    parts = line.strip.split(",")
    new(
      parts[0],
      Time.parse(parts[1]),
      (Time.parse(parts[2]) rescue nil)
    )
  end

  attr_reader :text

  def completed?
    @end_time
  end

  def complete!
    @end_time = Time.new
  end

  def duration
    return 0 unless completed?

    (@end_time - @start_time).to_i
  end

  def to_s
    "#{@text},#{@start_time},#{@end_time}\n"
  end
end


class TaskList
  def initialize(tasks = [])
    @tasks = tasks
  end

  def self.from_file(filename)
    instance = new
    instance.load(filename)
    instance
  end

  def load(filename)
    File.open(filename, "r") do |file|
      file.each do |line|
        self << Task.parse(line)
      end
    end
  end

  include Enumerable

  def each
    @tasks.each { |t| yield t }
  end

  def <<(task)
    @tasks << task
    self
  end

  def [](index)
    @tasks[index]
  end

  def []=(index, task)
    @tasks[index] = task
  end

  def size
    @tasks.size
  end

  def num_completed
    @tasks.select(&:completed?).size
  end

  def num_open
    @tasks.reject(&:completed?).size
  end

  def print_statistics
    print self.size, " Aufgaben im System\n"
    print self.num_open, " offen, ", self.num_completed, " erledigt\n"
    @tasks.reject(&:completed?).each do |task|
      print "OFFEN: ", task.text, "\n"
    end
    @tasks.select(&:completed?).each do |task|
      print "ERLEDIGT: ", task.text, "\n"
    end
  end

  def save(filename)
    File.write(
        filename,
        map(&:to_s).join
    )
end
end


case ARGV.shift
when "done"
  list = TaskList.from_file "tasks.txt"
  
  if list.none? { |task| task.text == ARGV.first }
    puts "Nichts zu erledigen."
  else
    task_index = list.find_index { |task| task.text == ARGV.first }
    
    if list[task_index].completed?
      puts "Nichts zu erledigen."
    else
    list[task_index].complete!
    list.save "tasks.txt"
    puts ARGV.first.to_s + " erledigt. Noch " + list.num_open.to_s + " Aufgaben offen."
    end
  end
end