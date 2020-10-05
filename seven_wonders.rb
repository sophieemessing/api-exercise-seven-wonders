require 'httparty'
require 'prettyprint'
require 'awesome_print'

BASE_URL = "https://us1.locationiq.com/v1/search.php"
KEY = "pk.96ba13c368d49149db9ba6490226fe84"


def get_location(search_term)

  location = {}

  response = HTTParty.get(BASE_URL, query: {
      q: search_term,
      key: KEY,
      format: "json"
    }
  )
  raise ArgumentError, "coordinates not found!" if response.code != 200

  location[search_term] = { lat: response.first["lat"], lon: response.first["lon"] }

  return location

end


def find_seven_wonders

  seven_wonders_locations = []

  seven_wonders = ["Great Pyramid of Giza",
                   "Gardens of Babylon",
                   "Colossus of Rhodes",
                   "Pharos of Alexandria",
                   "Statue of Zeus at Olympia",
                   "Temple of Artemis",
                   "Mausoleum at Halicarnassus"]

  seven_wonders.each do |wonder|
    sleep(0.5)
    seven_wonders_locations << get_location(wonder)
  end
  return seven_wonders_locations
end

ap find_seven_wonders
