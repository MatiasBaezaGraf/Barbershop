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
    now = chosen.time
    for i in 0..96
      nextturn = now + (15*i).minutes
      times.push(nextturn)
    end
    times
  end

  def self.posibles(busy, times, day, d, turn)
    free = times
    freetimes = []
    unicos = []
    horarios = []
    occupied = busy.sort
    toDelete = []
    duration = d/15
    index = 0
    u = 0

    for h in Freetime.all.where(:barber_id => turn.barber.id)
      if h.permanent.to_i == 0 and h.day.strftime("%d-%m-%Y") == day.strftime("%d-%m-%Y")
        u = 1
        unicos.push(h)
      end

      if u == 0
        freetimes = Freetime.all.where(:barber_id => turn.barber.id)
      else
        freetimes = unicos
      end
    end

    puts "Unicosooooososososoos: #{freetimes}"

    for h in freetimes
      op = h.from
      cl = h.to
      horarios.push([op, cl])
      libres = []
      inicio = []
      final = []

      for f in free
        if f.strftime("%H:%M") >= op.strftime("%H:%M") and f.strftime("%H:%M") <= cl.strftime("%H:%M")
          libres.push(f)
        end
      end

      inicio.push(libres[0])

      for i in occupied
        if i[0].strftime("%Y-%m-%d") == day.strftime("%Y-%m-%d") and i[0].strftime("%H:%M") >= op.strftime("%H:%M") and i[0].strftime("%H:%M") <= cl.strftime("%H:%M")
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

      final.push(libres[libres.length - 2])

      for i in inicio
        if i == final[inicio.index(i)]
          toDelete.push(i)
        else
          puts "Pruebaaaaaaaaaaaaaa #{inicio}, #{final}"
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
    end

    for h in horarios
      for f in free
        if horarios.length == 1
          if f.strftime("%H:%M") < h[0].strftime("%H:%M") or f.strftime("%H:%M") > h[1].strftime("%H:%M")
            puts "Ifffffffffffffff #{f}, #{h[0]}, #{h[1]}"
            toDelete.push(f)
          end
        elsif f.strftime("%H:%M") < h[0].strftime("%H:%M") and horarios.index(h) == 0 and horarios.length > 1 #Agregamos a la lista de eliminados todos los tiempos anteriores al inicio de trabajo del barbero
          toDelete.push(f)
        elsif !horarios[horarios.index(h) + 1].blank?
          if f.strftime("%H:%M") > h[1].strftime("%H:%M") and f.strftime("%H:%M") < horarios[horarios.index(h) + 1][0].strftime("%H:%M")
            toDelete.push(f)
          end
        elsif f.strftime("%H:%M") > h[1].strftime("%H:%M") and (horarios.index(h)) == (horarios.length - 1)
          toDelete.push(f)
        end
      end
    end
    puts "Deleteeeeeeeeeee: #{toDelete}"

    for d in toDelete
      free.delete_if {|element| element == d}
    end

    if not freetimes.blank?
      return free
    else
      return []
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
