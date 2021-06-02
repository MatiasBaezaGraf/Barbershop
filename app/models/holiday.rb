class Holiday < ApplicationRecord
  belongs_to :barber

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
