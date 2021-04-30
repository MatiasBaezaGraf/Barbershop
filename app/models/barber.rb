class Barber < ApplicationRecord
    has_many :turns

    has_many :has_barbers
    has_many :services, through: :has_barbers

    def busy(barber_id, day)
        busy = []
        for t in Turn.all
            count = []
            puts ("id: #{t.barber_id} , #{barber_id}")
            puts ("Time: #{t.time.strftime("%Y-%m-%d")} , #{day.to_date}")
            if t.barber_id == barber_id and t.time.strftime("%Y-%m-%d") == day.to_date
                
                i = t.time
                e = t.time + t.count_hours
                count = [i, e]
            end
            busy.push(count)
        end

        busy
        
    end

    def free(day)
        free = []
        inicio = "16:00"
        barber = Barber.where(:id => self.id)
        puts ("Self id: #{self.id}")
        busy = busy(self.id, day)
        for b in busy
            if b.blank?
                puts ("blank")
            else
                puts ("hola #{b[0]}")
            end
        end
    end
    
    
end
