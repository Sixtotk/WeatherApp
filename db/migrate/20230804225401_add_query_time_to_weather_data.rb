class AddQueryTimeToWeatherData < ActiveRecord::Migration[7.0]
  def change
    add_column :weather_data, :query_time, :datetime
  end
end
