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
            count = []
            i = DateTime.new
            e = DateTime.new
            puts ("id: #{t.barber_id} , #{barber_id}")
            puts ("Time: #{t.time.strftime("%Y-%m-%d")} , #{day}")
            puts "Count: #{t.count_hours}"
            if t.barber_id == barber_id and t.time.strftime("%Y-%m-%d").to_date == day.to_date
                puts "horasssssss: #{t.count_hours[0]}, #{t.count_hours[1]}"
                i = i + (t.time.hour).hour
                i = i + (t.time.min).min
                e = e + (t.time.hour + t.count_hours[0]).hour
                e = e + (t.time.min + t.count_hours[1]).min
                count.push(i)
                count.push(e)
                puts("count: #{t.time.hour}, #{e}")
            end
            if count.blank?
                busy.push(count)
            else
                busy = reformat(count)
            end
        end

        busy
        
    end

    def reformat(count)
        time = []
        puts("Reformat: #{count}")
        e = count[1]
        hour = 0

        
        time 
        time
      end

    def free(day, barber_id)
        free = []
        inicioM = [9, 00]
        cierreM = [12, 30]
        inicioT = [16, 00]
        cierreT = [20, 00]
        barber = Barber.where(:id => barber_id)
        busy = busy(barber_id, day)
        
        puts(busy)
        
    end
    
end
