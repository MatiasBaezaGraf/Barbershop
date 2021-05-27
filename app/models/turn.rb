class Turn < ApplicationRecord
  belongs_to :barber

  has_many :has_turn
  has_many :services, through: :has_turn

  def self.selectable_dates
    days = []
    today = Date.today
    for i in 0..14
      if i != 0
        nextday = today + i.day
        days.push(nextday)
      end
    end
    days
  end

  def self.weekends_off
    weekends = []
    today = Date.today
    tomorrow = Date.new(2021,05,12)
    weekends.push(tomorrow)

    for i in 0..14
      if i != 0
        nextday = today + i.day
        if (nextday.strftime("%u").to_i == 6 || nextday.strftime("%u").to_i == 7)
          weekends.push(nextday)
        end
      end
    end
    
    weekends
  end

  def self.selectable_times(id)
    xi = id
    chosen = nil
    barber = nil
    for t in Turn.all
      if xi.to_i == t.id.to_i
        chosen = t
        barber = t.barber
      end
    end
    times = []
    now = chosen.time + 8.hours
    for i in 0..20
      nextturn = now + (15*i).minutes
      times.push(nextturn)
    end
    times
  end

  def self.posibles(busy, times, day)
    puts "Day: #{day}"
    libres = times
    for i in busy
      index = 0
      if i[0].strftime("%Y-%M-%d") == day.strftime("%Y-%M-%d")
        puts i
        for t in libres
          print "TTTTTTTTTTTTTTTTTTTTTTT: #{t.strftime("%H:%M")}, #{i[0].strftime("%H:%M")}"
          print "Libresssssssssss: #{libres[index]}"
          index = index + 1
        end
      end
    end
    puts "Times: #{times}"
  end

  def self.find_by_client(client)
    turns = []
    clientup = client.upcase

    Turn.all.each do |t|
      if t.client.upcase.include? clientup
        turns.push(t)
      end
    end
    
    turns
  end
  
  def self.find_by_range(from, to)
    turns = []
    
    if false
      turns = Turn.all
    else
      puts 678
      Turn.all.each do |t|
        if t.time >= from && t.time <= to
          turns.push(t)
        end
      end
    end

    turns
  end

  def self.find_by_day(selecteday)
    turns = []

    Turn.all.each do |t|
      if t.time.strftime("%Y-%m-%d") == selecteday
        turns.push(t)
      end
    end

    turns
  end

  def self.work_or_free(id)
    chosen = nil
    barber = nil
    for t in Turn.all
      if id.to_i == t.id.to_i
        chosen = t
        barber = t.barber
      end
    end

    busy = []
    modulecounter = 0

    for t in Turn.all
      if t.barber == barber
        busy.push([t.time, t.count_hours/15])
      end
    end
    busy
  end

  def count_hours
    count = 0
    t = []

    for t in Turn.all
        if t.id == self.id
            for s in t.services
                count = count + s.duration
            end
        end
    end

    count
    #t = reformat(count)
  end

  def reformat(count)
    t = []
    hour = 0
    min = 0
    loop do
      if count >= 60
        hour = hour + 1
        min = min - 60
        count = count - 60
      else
        min = count
        break
      end
    end
    t = [hour, min]
    t
  end

end
