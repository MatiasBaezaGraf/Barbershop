class Barber < ApplicationRecord
    has_many :turns

    has_many :has_barbers
    has_many :services, through: :has_barbers

    def freeConvert(day, barber_id, time)

        
    end

    def self.today_busy(id)
        times = [0,0]
        Turn.all.each do |t|
            if t.edit == 0 && t.time
                if (t.time.strftime("%Y-%m-%d") == Date.today.strftime("%Y-%m-%d")) && (t.barber.id.to_s == id.to_s)
                    times.push([t.time.strftime("%H:%M"), t.count_hours/15, t.services])
                end
            end
        end
        
        puts "Holaaaaaa"
        puts times

        times
    end
    def self.tomorrow_busy(id)
        times = [0,0]
        Turn.all.each do |t|
            if t.edit == 0 && t.time
                if (t.time.strftime("%Y-%m-%d") == (Date.today + 1.day).strftime("%Y-%m-%d")) && (t.barber.id.to_s == id.to_s)
                    times.push([t.time.strftime("%H:%M"), t.count_hours/15, t.services])
                end
            end
        end

        times
    end
    def self.after_busy(id)
        times = [0,0]
        Turn.all.each do |t|
            if t.edit == 0 && t.time
                if (t.time.strftime("%Y-%m-%d") == (Date.today + 2.days).strftime("%Y-%m-%d")) && (t.barber.id.to_s == id.to_s)
                    times.push([t.time.strftime("%H:%M"), t.count_hours/15, t.services])
                end
            end
        end

        times
    end

    def self.schedule
        times = []
        now = (DateTime.now.beginning_of_day + 8.hours)

        for i in 0..40
            nextturn = now + (15*i).minutes
            times.push(nextturn.strftime("%H:%M"))
        end
        
        times
    end

    def free(day, barber_id)
        free = []
        inicioM = [9, 00]
        cierreM = [12, 30]
        inicioT = [16, 00]
        cierreT = [20, 00]
        barber = Barber.where(:id => barber_id)
        busy = busy(barber_id, day)
        
        puts("Busyyyy: #{busy}")
        
        if barber_id == 3
            busy[0][0].strftime("%k:%M")
        end
    end
    
end
