require "rails_helper"

RSpec.describe Airline, type: :model do
  describe "relationships" do
    it {should have_many :flights}
  end

  describe "model_functions" do
    it "unique_adult_passengers" do
      beth = Passenger.create(name: "Beth", age: 20)
      fred = Passenger.create(name: "Fred", age: 8)

      airline = Airline.create(name: "United")
      flight_1 = airline.flights.create(number: "1")
      flight_2 = airline.flights.create(number: "2")
      PassengerFlight.create(passenger: beth, flight: flight_1)
      PassengerFlight.create(passenger: beth, flight: flight_2)
      PassengerFlight.create(passenger: fred, flight: flight_2)
      
      airline.unique_adult_passengers.each do |passenger|
        expect(passenger.name).to eq("Beth")
        expect(passenger.name).to_not eq("Fred")
      end
    end
  end
end
