class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @flight = Flight.find(params[:flight_id])
    passenger_num = params[:passengers]

    passenger_num.to_i.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.build(booking_params)

    if @booking.save
      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.expect(booking: [ :flight_id, passengers_attributes: [ [ :name, :email ] ] ])
  end
end
