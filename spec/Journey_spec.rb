require 'journey'

describe Journey do

  it "remembers which station it touched in from" do
    subject.start_journey("Richmond")
    expect(subject.entry_station).to eq "Richmond"
  end

  it "remembers which station it touched out from" do
    subject.finish_journey("Aldgate")
    expect(subject.exit_station).to eq "Aldgate"
  end

end
