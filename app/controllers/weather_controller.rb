class WeatherController < ApplicationController
  require 'httparty'

  def index
  end

  def search
    city = params[:city]
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=8b7a53c5908ca1fd6e95d5c642220cbb")
    weather_data = JSON.parse(response.body) if response.ok?
    weather_data['main']['temp'] = convert_to_celsius(weather_data['main']['temp']) if weather_data

    @weather_data = weather_data

    if weather_data
      WeatherData.create_from_weather_data(city, weather_data['main']['temp'], weather_data['weather'][0]['description'])
    end

    respond_to do |format|
      format.html { render partial: 'weather_result', locals: { weather_data: @weather_data } }
    end
  end

  def history
    @weather_data_history = WeatherData.order(created_at: :desc)
  end

  def destroy
    weather_data = WeatherData.find(params[:id])
    weather_data.destroy
    redirect_to history_path, notice: 'Weather data deleted successfully.'
  end

  private

  def convert_to_celsius(temp_kelvin)
    (temp_kelvin.to_f - 273.15).round(2)
  end

end