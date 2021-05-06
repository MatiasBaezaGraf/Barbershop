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
            puts ("id: #{t.barber_id} , #{barber_id}")
            puts ("Time: #{t.time.strftime("%Y-%m-%d")} , #{day}")
            puts "Count: #{t.count_hours}"
            if t.barber_id == barber_id and t.time.strftime("%Y-%m-%d").to_date == day.to_date
                puts "horasssssss: #{t.count_hours[0]}, #{t.count_hours[1]}"
                i = [t.time.hour, t.time.min]
                e = [t.time.hour + t.count_hours[0], t.time.min + t.count_hours[1]]
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

        loop do
            if e[1] >= 60
                e = [(e[0]+1), (e[1]-60)]
            else
                break
            end
        end
        time = [count[0], e]
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
        if busy[0].blank?
            puts "nil"
        else
            puts ("Busy: #{busy[0][0][0]}")
        end
        puts "length: #{busy}"
        if busy.blank? 
            free.push(inicio, cierre)
        else
            count = 0
            for b in busy
                if b.blank? or b[0].blank?
                    puts("bbbbbbbbb: #{b[0]}")
                    break
                elsif b.blank? and count == busy.lenght-1
                    free.push(inicio, cierre)
                else
                    if b[0] >= inicioM[0] and b[0] < cierreM[0]
                        inicio = inicioM
                        cierre = cierreM
                    else
                        inicio = inicioT
                        cierre = cierreT
                    end
    
                    puts ("#{b[0][0]}, #{inicio[0]}")
                    if b[0][0] >= inicio[0] and count == 0
                        count = count + 1
                        free.push([inicio, [b[0][0], b[0][1]]])
                        

                    elsif b[0][0]>busy[count-1][1][0]
                        free.push([[busy[count-1][1][0], busy[count-1][1][1]], [b[0][0], b[0][1]]])
                        count = count + 1

                    elsif b[0][0]==busy[count-1][1][0] and b[0][1]>busy[count-1][1][1] and count != busy.length-1
                        free.push([[busy[count-1][1][0], busy[count-1][1][1]], [b[0][0], b[0][1]]])
                        count = count + 1

                    elsif b[0][0]>busy[count-1][1][0] and count != busy.length-1
                        free.push([[busy[count-1][1][0], busy[count-1][1][1]], [b[0][0], b[0][1]]])
                        count = count + 1

                    elsif b[0][0]==busy[count-1][1][0] and b[0][1]>busy[count-1][1][1] and count == busy.length-1
                        free.push([[busy[count-1][1][0], busy[count-1][1][1]], [b[0][0], b[0][1]]])
                        free.push([[b[1][0], b[1][1]], cierre])
                        count = count + 1

                    elsif b[0][0]==busy[count-1][1][0] and b[0][1]==busy[count-1][1][1] and count == busy.length-1
                        free.push([[b[1][0], b[1][1]], cierre])
                        count = count + 1

                    elsif b[0][0]>busy[count-1][1][0] and count == busy.length-1
                        free.push([[busy[count-1][1][0], busy[count-1][1][1]], [b[0][0], b[0][1]]])
                        free.push([[b[1][0]], b[1][1]], cierre)
                        count = count + 1

                    end
                end
            end
        end
        free
    end
    
end
