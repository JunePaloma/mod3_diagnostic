class SearchController < ApplicationController
  def index
      @conn = Faraday.new(url: "https://developer.nrel.gov") do |faraday_object|
      faraday_object.adapter Faraday.default_adapter
    end
    @stations = Station.new(search_by_state)
    binding.pry
  end

    def search_by_state
    response = @conn.get("/api/alt-fuel-stations/v1.json?fuel_type=E85,ELEC&radius=6&location=80203&limit=10&api_key=#{ENV["nrel_api_key"]}")
    JSON.parse(response.body, symbolize_names: true)[:fuel_stations]
    end
end
    class Station
      def initialize(attrs)
        name = :station_name
        address = :street_address
        fuel_type = :fuel_type_code
        access_times = :access_days_time
    end
      def address
        # need a methond to concat the address
      end
end
