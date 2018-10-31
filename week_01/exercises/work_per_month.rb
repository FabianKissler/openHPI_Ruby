# openHPI - Programmieren mit Ruby
# Woche 1 - Hausaufgabe Teil 3

def work_per_month(ary_work)
    nary = ary_work.group_by{ |t| 
        t[:date] 
    }.transform_values { |tasks|
        tasks.reduce(0) { |sum, t|
            sum + t[:time] 
        }
    }.to_a.group_by { |e|
        e[0][0..6]
    }.transform_values { |tasks|
        tasks.reduce(0) { |sum, t|
            sum + t[1] 
        } / tasks.length
    }
end


work = [
    {work: "item 1", date: "2017-04-26", time: 20},
    {work: "item 2", date: "2017-04-27", time: 27},
    {work: "item 3", date: "2017-04-27", time: 33},
    {work: "item 4", date: "2017-05-05", time: 20},
    {work: "item 5", date: "2017-05-06", time: 12},
    {work: "item 6", date: "2017-05-14", time: 10},
  ]

  puts work_per_month(work)