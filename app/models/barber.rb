class Barber < ApplicationRecord
    has_many :turns

    has_many :has_barbers
    has_many :services, through: :has_barbers

    def freeConvert(day, barber_id, time)

        
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
