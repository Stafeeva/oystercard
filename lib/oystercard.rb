require_relative 'Journey'

class Oystercard
  attr_reader :balance, :history, :journey

  MAX_MONEY = 90
  MIN_MONEY = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @history = []
  end

  def topup(value)
    fail "Your balance cannot go over £#{Oystercard::MAX_MONEY}." if @balance + value > MAX_MONEY
    @balance += value
  end

  def touch_in(station)
    fail "min. balance of £#{Oystercard::MIN_MONEY} not reached" if @balance <= MIN_MONEY
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey.finish_journey(station, self)
    deduct(MINIMUM_FARE)
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
