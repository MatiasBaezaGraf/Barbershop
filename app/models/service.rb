class Service < ApplicationRecord
    has_many :has_barbers
    has_many :barbers, through: :has_barbers

    has_many :has_turns
    has_many :turns, through: :has_turns
end
