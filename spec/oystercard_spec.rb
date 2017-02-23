require "oystercard"

describe Oystercard do
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  context "#balance" do
  it "carries a balance" do
    expect(subject.balance).to eq 0
  end

  it "has an effect on the balance" do
    expect{ subject.top_up(10)}.to change{ subject.balance }.by 10
  end

end

  context "#top_up" do

    it "responds to topup with 1 argument" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end


    it "allows topup with a value" do
      expect(subject.top_up(20)).to eq 20
    end


    it "will not topup when the balance would be over £#{Oystercard::MAX_MONEY}" do
      expect{subject.top_up(91)}.to raise_error "Your balance cannot go over £#{Oystercard::MAX_MONEY}."
    end

  end

  context "#touch_in" do
    before(:each) do
      subject.top_up(50)
    end

    it "is initially not in a journey" do
      expect(subject).not_to be_on_journey
    end

    it "responds to touch_in method" do
      expect(subject).to respond_to(:touch_in)
    end

    it "registers as being in a journey after touchin" do
      subject.touch_in(entry_station)
      expect(subject).to be_on_journey
    end

  end

context "#touch_in_errors" do
    it "raises an error when minimum amount not reached" do
      expect{ subject.touch_in(entry_station) }.to raise_error "min. balance of £#{Oystercard::MIN_MONEY} not reached"
    end

end

context "#touch_out" do
  before(:each) do
    subject.top_up(50)
  end

  it "responds to touch_out method" do
    expect(subject).to respond_to(:touch_out)
  end

  it "registers as journey complete after touch_out" do
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_on_journey
  end

  it "deducts minimum fare when touch_out" do
  subject.touch_in(entry_station)
  expect{ subject.touch_out(exit_station)}.to change{ subject.balance}.by -(Oystercard::MINIMUM_FARE)
  end

  it "causes OysterCard to forget entry station" do
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.current_journey).to eq nil
  end


  end

  context "#penalty fare" do
    it "should deduct penalty fare when touch_in twice" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect{subject.touch_in(entry_station)}.to change{ subject.balance }.by -(Oystercard::PENALTY_FARE)
    end
  end
end
