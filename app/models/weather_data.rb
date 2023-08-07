class WeatherData < ApplicationRecord
  validates :city, presence: true, uniqueness: true
  validates :temperature, presence: true

  def self.create_from_weather_data(city, temperature, description)
    weather_data = find_or_initialize_by(city: city)
    weather_data.update(temperature: temperature, description: description, query_time: Time.current)
  end
end