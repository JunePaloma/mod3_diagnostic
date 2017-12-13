require 'rails_helper'
feature "User can search for stations by location" do
  scenario "with a valid zip code" do
    visit "/"
    within(".search-field") do
          fill_in("q", :with => "80203", :visible => false)
    end
    click_on "Locate"
    expect(current_path).to eq  "/search?80203"
    expect(station.count).to eq(10)  #within 6 miles sorted by distance
#  And the stations should be limited to Electric and Propane
  # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
  end
end
