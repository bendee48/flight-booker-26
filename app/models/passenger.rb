class Passenger < ApplicationRecord
  has_many :passenger_bookings
  has_many :bookings, through: :passenger_bookings
end
