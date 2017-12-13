class SearchController < ApplicationController
  def index
      @conn = Faraday.new(url: "https://developer.nrel.gov") do |faraday_object|
      faraday_object.adapter Faraday.default_adapter
    end

    @stations = search_by_state.map do |station|
      Station.new(station)
    end
  end

    def search_by_state
    response = @conn.get("/api/alt-fuel-stations/v1.json?fuel_type=E85,ELEC&radius=6&location=80203&limit=10&api_key=#{ENV["nrel_api_key"]}")
    JSON.parse(response.body, symbolize_names: true)[:fuel_stations]
    end
end
    class Station
      attr_reader :name, :address, :fuel_type, :access_times
      def initialize(attrs = {})
        @name = attrs[:station_name]
        @address = attrs[:street_address]
        @fuel_type = attrs[:fuel_type_code]
        @access_times = attrs[:access_days_time]
    end

end
