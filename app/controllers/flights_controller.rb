class FlightsController < ApplicationController
  def index
    @airports = Airport.all
    @departure_times = Flight.order(:start).select(:id, :start)
  end
end
