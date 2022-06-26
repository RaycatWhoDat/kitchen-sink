require 'net/http'
require 'json'

response = JSON.parse Net::HTTP.get URI "http://api.open-notify.org/astros.json"
printf "%25s | %10s\n", "NAME", "CRAFT"
response["people"].each do |astronaut|
  printf "%25s | %10s\n", astronaut["name"], astronaut["craft"]
end

