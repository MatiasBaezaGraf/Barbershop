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
    busy = chosen.busy(barber, chosen.time.strftime("%Y-%m-%d"))
    puts ("Busyyyyyyyyyyyyyyyyyyyyyyyy #{busy}")
    now = chosen.time + 8.hours
    for i in 0..20
      nextturn = now + (15*i).minutes
      times.push(nextturn)
    end
    times
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

  def busy(barber_id, day)
    busy = []
    turns = Turn.where(:barber_id => barber_id).order(time: :asc)
    
    for t in turns
        count = []
        i = Time.new(2000, 01, 01)
        e = Time.new(2000, 01, 01)
        duration = [t.count_hours[0], t.count_hours[1]]
        if t.barber_id == barber_id and t.time.strftime("%Y-%m-%d").to_date == day.to_date 
            i = i + (t.time.hour).hour
            i = i + (t.time.min).minutes
            e = e + (t.time.hour + duration[0]).hour
            e = e + (t.time.min + duration[1]).minutes
            count.push(i)
            count.push(e)               
        end
        if count.blank?
            break
        else
            busy.push(count)
        end
    end

    busy
    
  end

end
