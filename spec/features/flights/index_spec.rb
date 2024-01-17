require "rails_helper"

RSpec.describe "experiment index page",type: :feature do
    before(:each) do
        @anna = Passenger.create(name: "Anna")
        @beth = Passenger.create(name: "Beth")
        @carl = Passenger.create(name: "Carl")
        @debb = Passenger.create(name: "Debb")
        @ella = Passenger.create(name: "Ella")

        @united = Airline.create(name: "United")
        @un_flight_1 = @united.flights.create(number: "1")
        @un_flight_2 = @united.flights.create(number: "2")
        PassengerFlight.create(passenger: @anna, flight: @un_flight_1)
        PassengerFlight.create(passenger: @beth, flight: @un_flight_1)
        PassengerFlight.create(passenger: @carl, flight: @un_flight_2)
        PassengerFlight.create(passenger: @anna, flight: @un_flight_2)

        @southwest = Airline.create(name: "SouthWest")
        @sw_flight_1 = @southwest.flights.create(number: "3")
        @sw_flight_2 = @southwest.flights.create(number: "4")
        PassengerFlight.create(passenger: @debb, flight: @sw_flight_1)
        PassengerFlight.create(passenger: @ella, flight: @sw_flight_2)
    end

    it "User Story 1, Flights Index Page" do
        # When I visit the flights index page
        visit "/flights"
        # I see a list of all flight numbers
        expect(page).to have_content(@un_flight_1.number)
        expect(page).to have_content(@un_flight_2.number)
        expect(page).to have_content(@sw_flight_1.number)
        expect(page).to have_content(@sw_flight_2.number)
        # And next to each flight number I see the name of the Airline of that flight
        expect(page).to have_content(@united.name)
        # And under each flight number I see the names of all that flight's passengers
        expect(@united.name).to appear_before(@carl.name)
    end

    it "User Story 2, Remove a Passenger from a Flight" do
        # When I visit the flights index page
        visit "/flights"
        # Next to each passengers name
        within "#flight-#{@sw_flight_2.number}" do
            expect(@ella.name).to appear_before("Remove")
        end
        # I see a link or button to remove that passenger from that flight
        within "#flight-#{@un_flight_2.number}" do
            within "#passenger-#{@anna.name}" do
                expect(page).to have_content(@anna.name)
                expect(page).to have_button("Remove")
                # When I click on that link/button
                click_on("Remove")
            end
        end
        # I'm returned to the flights index page
        expect(page).to have_current_path("/flights")
        # And I no longer see that passenger listed under that flight,
        within "#flight-#{@un_flight_2.number}" do
            expect(page).to_not have_content(@anna.name)
        end
        # And I still see the passenger listed under the other flights they were assigned to.
        within "#flight-#{@un_flight_1.number}" do
            expect(page).to have_content(@anna.name)
        end
    end
end