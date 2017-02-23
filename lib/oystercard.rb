require_relative 'Journey'
require_relative 'Journeylog'

class Oystercard
  attr_reader :balance, :history, :journey

  MAX_MONEY = 90
  MIN_MONEY = 1
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @history = []
    @journey = nil
  end

  def topup(value)
    fail "Your balance cannot go over £#{Oystercard::MAX_MONEY}." if @balance + value > MAX_MONEY
    @balance += value
  end

  def touch_in(station)
    deduct(PENALTY_FARE) if on_journey?
    @journey = Journeylog.new
    fail "min. balance of £#{Oystercard::MIN_MONEY} not reached" if @balance <= MIN_MONEY
    @journey.start_journey(station)
  end

  def touch_out(station)
    if @journey == nil
       deduct(PENALTY_FARE)
       @journey =  Journeylog.new
    else
      fare = Journey.new.fare
      deduct(fare)
    end
    @journey.finish_journey(station)
    @journey.save_history(self)
    @journey = nil
end

  def on_journey?
    !!@journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
