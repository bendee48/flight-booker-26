class FlightsController < ApplicationController
  def index
    @airports = Airport.all
    @departure_dates = Flight.unique_flight_dates
    search = params[:search]

    # if the search form has been submitted with all values present
    if search&.values&.all?(&:present?)
      @available_flights = Flight.find_flights(departure_airport_id: search[:departure_airport_id],
                                               arrival_airport_id: search[:arrival_airport_id],
                                               departure_date: search[:departure_date])
    end
  end
end
