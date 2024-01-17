class Airline < ApplicationRecord
   has_many :flights

   def unique_adult_passengers
      flights
         .joins(:passengers)
         .select(:name)
         .where("passengers.age > 17")
         .distinct
   end
end