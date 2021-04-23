class Turn < ApplicationRecord
  belongs_to :barber

  has_many :has_turn
  has_many :services, through: :has_turn

  def count_hours
    count = 0

    for t in Turn.all
        if t.id == self.id
            for s in t.services
                count = count + s.duration
            end
        end
    end

    count
end

end
