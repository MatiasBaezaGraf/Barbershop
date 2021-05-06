class Barber < ApplicationRecord
    has_many :turns

    has_many :has_barbers
    has_many :services, through: :has_barbers

    def freeConvert(day, barber_id, time)

        
    end
    

    def busy(barber_id, day)
        busy = []
        turns = Turn.where(:barber_id => barber_id).order(time: :asc)
        
        for t in turns
            puts ("Time: #{t.time}")
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
