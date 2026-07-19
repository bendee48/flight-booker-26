class Flight < ApplicationRecord
  belongs_to :arrival_airport, class_name: "Airport", foreign_key: :arrival_airport_id
  belongs_to :departure_airport, class_name: "Airport", foreign_key: :departure_airport_id
  has_many :bookings

  def self.find_flights(departure_airport_id:, arrival_airport_id:, departure_date:)
    where(departure_airport_id: departure_airport_id, arrival_airport_id: arrival_airport_id)
    .where("DATE(start) = ?", departure_date)
  end

  def self.unique_flight_dates
    select("DISTINCT DATE(start) as start").map { |d| [ d.start.strftime("%a, %d %b %Y"), d.start ] }
  end
end
