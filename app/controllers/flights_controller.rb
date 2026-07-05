class FlightsController < ApplicationController
  def index
    @airports = Airport.all
    @departure_dates = Flight.unique_flight_dates
    @search_submitted = all_search_fields_present?

    if @search_submitted
      @available_flights = Flight.find_flights(departure_airport_id: search_params[:departure_airport_id],
                                               arrival_airport_id: search_params[:arrival_airport_id],
                                               departure_date: search_params[:departure_date])
      @number_of_passengers = search_params[:passengers]
    end
  end

  private

  def search_params
    params[:search]
  end

  def all_search_fields_present?
    search_params&.values&.all?(&:present?)
  end
end
