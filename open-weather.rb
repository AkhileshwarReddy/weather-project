require 'net/http'
require 'json'

class OpenWeather	
	def get_weather(city_name)
		begin
			uri = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city_name}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
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

