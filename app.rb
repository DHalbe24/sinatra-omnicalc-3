require "sinatra"
require "sinatra/reloader"
require "http"
require "sinatra/cookies"

get("/zebra") do
  # cookies.store("color", "pink")
  # cookies.store("sport", "tennis")
  # or, similarly, we can use a more concise technique: []
  cookies["color"] = "pink"
  cookies["sport"] = "tennis"

  # The cookies hash would now look like:
  #    { "color" => "purple", "sport" => "tennis" }

  "We stored two values, under the keys 'color' and 'sport'"
end

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end

get("/umbrella") do
  erb(:umbrella_form)
end

post("/process_umbrella") do
  @user_location = params.fetch("user_loc")

  url_encoded_string = @user_location.gsub(" ", "+")

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_encoded_string}&key=AIzaSyA2sS7veAf82D7PNeDC-n1NuWD5BUMSxd0"

  @raw_response = HTTP.get(gmaps_url).to_s

  @parsed_response = JSON.parse(@raw_response)

  @loc_hash = @parsed_response.dig("results", 0, "geometry", "location")

  @latitude = @loc_hash.fetch("lat")
  @longitude = @loc_hash.fetch("lng")

  cookies["last_location"] = @user_location
  cookies["last_lat"] = @latitude
  cookies["last_lng"] = @longitude

  erb(:umbrella_results)
end





'''
require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  "
  <p>Welcome to OmniCalc 3</p>
  "
end

get("/umbrella") do
  erb(:umbrella_form)
end

get("/process_umbrella") do
  @user_location = params.fetch("user_loc")
  url_encoded_string = @user_location.gsub(" ", "+")

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_encoded_string}&key=AIzaSyA2sS7veAf82D7PNeDC-n1NuWD5BUMSxd0"
  
  @raw_response = HTTP.get(gmaps_url).to_s

  @parsed_response = JSON.parse(@raw_response)

  @loc_hash = @parsed_response.dig("results", 0, "geometry", "location")

  @latitude = @loc_hash.fetch("lat")
  @longitude = @loc_hash.fetch("lng")

  erb(:umbrella_results)
end
'''
