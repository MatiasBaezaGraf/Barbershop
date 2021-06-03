class Freetime < ApplicationRecord
end

def public.toArray(start, final)
  inter = start
  comp = final
  times = []
  while inter <= comp
    times.push(inter.strftime("%H:%M"))
    inter = inter + 15.minutes
  end
  puts "osieeeeeee"
  puts times 
  times
end

def public.base_times
  times = []
  now = Date.today
  puts now
  for i in 0..48
    nextturn = now + (15*i).minutes
    times.push(nextturn.strftime("%H:%M"))
  end
  times
end

def barbername(id, perm)
  barbero = ""
  Barber.all.each do |b|
    if b.id.to_s == id.to_s
      barbero = b.first_name
    end
  end

  if perm == -1
    barbero = "No aplica"
  end

  barbero
end

def tipazo(perm)
  tipo = ""
  if perm == -1
    tipo = "General"
  elsif perm == 1
    tipo = "Permanente"
  else
    tipo = "Único"
  end
  tipo
end