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

  def self.posibles(busy, times, day, d)
    libres = times
    toDelete = []
    inicio = []
    final = []
    duration = d/15
    index = 0
    for i in busy
      if i[0].strftime("%Y-%m-%d") == day.strftime("%Y-%m-%d")
        index = libres.index(i[0])

        puts "LIBRES: #{inicio[0]}, #{i[0]}"

        
        inicio.push(libres[libres.index(i[0]) + i[1]])
        

        for t in (1..i[1]).step(1)
          toDelete.push(libres[index])
          index = index + 1
        end
      end
    end
    final.push(libres[libres.length - 2])
    puts "INICIOOOOOOOOOOOO: #{inicio}"
    puts "FiNALLLLLLLLLLLLLLL: #{final}"
    for i in inicio
      modules = libres.index(final[inicio.index(i)]) - libres.index(i) + 1

      if modules >= duration
        ind = libres.index(final[inicio.index(i)]) - duration + 2
        for m in 1..duration
          toDelete.push(libres[ind])
          ind = ind + 1
        end
      else
        ind = libres.index(i)
        for m in 1..modules
          toDelete.push(libres[ind])
          ind = ind + 1
        end
      end

      # for d in toDelete
      #   libres.delete_if {|element| element == d}
      # end
    end
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
      if t.barber == barber and t.edit == 0
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

  end

end
