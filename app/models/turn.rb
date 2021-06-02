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

  def self.weekends_off(id)
    barid = []

    Turn.all.each do |tu|
      if id.to_s == tu.id.to_s
        barid.push(tu.barber_id)
      end
    end

    puts "Holasslaldladlalfalflalfdsfas"
    puts barid
          
          

    weekends = []
    today = Date.today

    for i in 0..14
      if i != 0
        nextday = today + i.day

        Holiday.all.each do |f|
          if barid[0].to_s == f.barber.id.to_s
            
            if f.permanent == 1
              if f.freeday.strftime("%a") == nextday.strftime("%a")
                weekends.push(nextday)
              end
            end
          end
        end
        #if (nextday.strftime("%u").to_i == 6 || nextday.strftime("%u").to_i == 7)
        #  weekends.push(nextday)
        #end
      end
    end   
    
    Holiday.all.each do |d|
      if barid[0].to_s == d.barber.id.to_s
        if d.freeday >= Date.today
          weekends.push(d.freeday)
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
    for i in 0..48
      nextturn = now + (15*i).minutes
      times.push(nextturn)
    end
    times
  end

  def self.posibles(busy, times, day, d)
    opM = "08:00".to_datetime
    clM = "13:00".to_datetime
    opA = "16:00".to_datetime
    clA = "20:00".to_datetime
    libres = times
    mañana = []
    tarde = []
    occupied = busy.sort
    toDelete = []
    inicio = []
    final = []
    duration = d/15
    index = 0

    inicio.push(libres[0])

    for i in occupied
      if i[0].strftime("%Y-%m-%d") == day.strftime("%Y-%m-%d")
        index = libres.index(i[0])

        #Crear los intervalos libres entre turno y turno
        if i[0] == libres[0]
          inicio.delete_at(0)
          inicio.push(libres[libres.index(i[0]) + i[1]])
        elsif i[0] != libres[0]
          inicio.push(libres[libres.index(i[0]) + i[1]])
          final.push(libres[libres.index(i[0]) -1])
        else
          inicio.push(libres[libres.index(i[0]) + i[1]])
        end

        #Añadir a lista de eliminados los modulos pertenecientes al turno
        for t in (1..i[1]).step(1)
          toDelete.push(libres[index])
          index = index + 1
        end
      end
    end

    for i in libres
      #Añadir a lista de eliminados los modulos fuera de horario
      if i.strftime("%H:%M").to_datetime >= clM and i.strftime("%H:%M").to_datetime < opA
        toDelete.push(i)
      end

      #Creamos la separacion entre horarios de mañana y de tarde
      if i.strftime("%H:%M").to_datetime >= opM and i.strftime("%H:%M").to_datetime <= clM
        mañana.push(i)
      elsif i.strftime("%H:%M").to_datetime >= opA and i.strftime("%H:%M").to_datetime <= clA
        tarde.push(i)
      end
    end

    final.push(libres[libres.length - 2])

    puts "Iniciooooooooooooooooooooo: #{inicio}"
    puts "Finallllllllllllllllllllll: #{final}"

    #Evaluamos que nuestro turno entre en los intervalos libres de la mañana
    for i in inicio
      if i == final[inicio.index(i)]
        toDelete.push(i)
      else
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
      end
    end

    #Evaluamos que nuestro turno entre en los intervalos libres de la tarde
    for i in inicio
      
    end

    for d in toDelete
      libres.delete_if {|element| element == d}
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
      if t.barber == barber and t.p == 1
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

  def formatDate(d)
    day = d.strftime("%a")
    month = d.strftime("%m")

    case day
    when "Sun"
      day = "Domingo"
    when "Mon"
      day = "Lunes"
    when "Tue"
      day = "Martes"
    when "Wed"
      day = "Miercoles"
    when "Thu"
      day = "Jueves"
    when "Fri"
      day = "Viernes"
    when "Sat"
      day = "Sabado"
    end

    case month
    when "01"
      month = "Enero"
    when "02"
      month = "Febrero"
    when "03"
      month = "Marzo"
    when "04"
      month = "Abril"
    when "05"
      month = "Mayo"
    when "06"
      month = "Junio"
    when "07"
      month = "Julio"
    when "08"
      month = "Agosto"
    when "09"
      month = "Septiembre"
    when "10"
      month = "Octubre"
    when "11"
      month = "Noviembre"
    when "12"
      month = "Diciembre"
    end


    return [day, month]

  end

end
