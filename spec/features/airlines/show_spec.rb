require "rails_helper"

RSpec.describe "experiment index page",type: :feature do
    before(:each) do
        @anna = Passenger.create(name: "Anna", age: 20)
        @beth = Passenger.create(name: "Beth", age: 20)
        @carl = Passenger.create(name: "Carl", age: 20)
        @debb = Passenger.create(name: "Debb", age: 20)
        @ella = Passenger.create(name: "Ella", age: 20)
        @fred = Passenger.create(name: "Fred", age: 8)

        @united = Airline.create(name: "United")
        @un_flight_1 = @united.flights.create(number: "1")
        @un_flight_2 = @united.flights.create(number: "2")
        PassengerFlight.create(passenger: @anna, flight: @un_flight_1)
        PassengerFlight.create(passenger: @beth, flight: @un_flight_1)
        PassengerFlight.create(passenger: @beth, flight: @un_flight_2)
        PassengerFlight.create(passenger: @carl, flight: @un_flight_2)
        PassengerFlight.create(passenger: @debb, flight: @un_flight_2)
        PassengerFlight.create(passenger: @ella, flight: @un_flight_2)
        PassengerFlight.create(passenger: @fred, flight: @un_flight_2)
    end

    it "User Story 3, Airline's Passengers" do
        # When I visit an airline's show page
        visit "/airlines/#{@united.id}"
        # Then I see a list of passengers that have flights on that airline
        expect(page).to have_content(@anna.name)
        expect(page).to have_content(@beth.name)
        expect(page).to have_content(@carl.name)
        expect(page).to have_content(@debb.name)
        expect(page).to have_content(@ella.name)
        # And I see that this list is unique (no duplicate passengers)
        expect(@anna.name).to_not appear_before(@anna.name)
        # And I see that this list only includes adult passengers.
        expect(page).to_not have_content(@fred.name)
    end
end