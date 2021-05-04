class Turn < ApplicationRecord
  belongs_to :barber

  has_many :has_turn
  has_many :services, through: :has_turn

  def count_hours
    count = 0
    time = []

    for t in Turn.all
        if t.id == self.id
            for s in t.services
                count = count + s.duration
            end
        end
    end

    time = reformat(count)
  end

  def reformat(count)
    time = []
    hour = 0
    min = 0
    loop do
      if count >= 60
        hour = hour + 1
        min = min - 60
        count = count - 60
      else
        min = count
        break
      end
    end
    time = [hour, min]
    time
  end

end
