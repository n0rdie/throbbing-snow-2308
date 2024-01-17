class Flights::PassengersController < ApplicationController 
    def destroy
        @passenger = Passenger.find(params[:id])
        @flight = Flight.find(params[:flight_id])

        @flight.passengers.delete(@passenger)

        redirect_to "/flights"
    end
end