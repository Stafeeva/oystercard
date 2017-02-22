require 'station'

describe Station do

  it "should have a name" do
    station = Station.new("Aldgate")
    expect(station.name).to eq "Aldgate"
  end

  it "should have a zone" do
    expect(station.zone).to eq zone
  end
end
