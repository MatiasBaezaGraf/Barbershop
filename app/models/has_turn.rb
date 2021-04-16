class HasTurn < ApplicationRecord
  belongs_to :turn
  belongs_to :service
end
