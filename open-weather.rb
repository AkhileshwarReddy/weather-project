require 'net/http'
require 'json'

# API_KEY = "eed51248a56975eaac956ecf809799c5"
# URL = "api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}"

class OpenWeather
	def initialize()
		@api_key = "eed51248a56975eaac956ecf809799c5"
	end
	
	def get_weather(city_name)
		begin
			uri = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city_name}&appid=#{@api_key}")
			res = Net::HTTP.get_response(uri)
			data = JSON.parse(res.body)
			data.each do |key, value|
				if value.class == Hash
					puts "#{key} : "
					value.each do |k, v|
						puts "\t#{k} : #{v}"
					end
				elsif value.class == Array
					puts "#{key} : "
					value.each do |item|
						item.each do |k, v|
							puts "\t#{k} : #{v}"
						end
					end
				else
					puts "#{key} : #{value}"		
				end
			end
		rescue StandardError => ex
			puts ex.message
		end
	end
end

weather = OpenWeather.new
print "Enter city name: "
city_name = gets.chomp()
weather.get_weather(city_name)

