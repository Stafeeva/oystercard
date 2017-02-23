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
    @current_journey = nil
    @journeylog = Journeylog.new
  end

  def topup(value)
    fail "Your balance cannot go over £#{Oystercard::MAX_MONEY}." if @balance + value > MAX_MONEY
    @balance += value
  end

  def touch_in(station)
    deduct(PENALTY_FARE) if on_journey?
    @current_journey = Journey.new
    fail "min. balance of £#{Oystercard::MIN_MONEY} not reached" if @balance <= MIN_MONEY
    @journeylog.start_journey(station)
  end

  def touch_out(station)
    if @current_journey == nil
       deduct(PENALTY_FARE)
       @current_journey =  Journey.new
    else
      fare = Journey.new.fare
      deduct(fare)
    end
    @journeylog.finish_journey(station)
    @current_journey = nil
end

  def on_journey?
    !!@current_journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
