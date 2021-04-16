class Service < ApplicationRecord
    has_many :barber_services
    has_many :barbers, through: :has_barbers

    has_many :turn_services
    has_many :turns, through: :has_turns
end
