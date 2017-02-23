require 'journeylog'

describe Journeylog do

  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  it "remembers which station it touched in from" do
    subject.start_journey("Richmond")
    expect(subject.entry_station).to eq "Richmond"
  end
  # 
  # it "remembers which station it touched out from" do
  #   subject.finish_journey("Aldgate")
  #   expect(subject.exit_station).to eq "Aldgate"
  # end

  context "#journey history" do

    it "should show us an empty journey history initially" do
      expect(subject.history).to eq []
    end

    it "remembers the entire journey" do
      subject.start_journey(entry_station)
      subject.finish_journey(exit_station)
      expect(subject.history).to eq [ { :entry_station => entry_station, :exit_station => exit_station } ]
    end

  end

end
