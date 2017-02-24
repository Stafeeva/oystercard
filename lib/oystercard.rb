require_relative 'Journey'
require_relative 'Journeylog'

class Oystercard

  attr_reader :balance, :journeylog

  MAX_MONEY = 90
  MIN_MONEY = 1
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journeylog = Journeylog.new
  end

  def top_up(value)
    fail "Your balance cannot go over £#{Oystercard::MAX_MONEY}." if @balance + value > MAX_MONEY
    @balance += value
  end

  def touch_in(station)
    check_when_touch_in
    @journeylog.start_journey(station)
    fail "min. balance of £#{Oystercard::MIN_MONEY} not reached" if @balance <= MIN_MONEY
  end

  def check_when_touch_in
    deduct(PENALTY_FARE) if on_journey?
    @journeylog.finish_journey(station = nil)
  end

  def touch_out(station)
    check_when_touch_out
    deduct(Journey.new.fare)
    @journeylog.finish_journey(station)
  end

  def check_when_touch_out
    if !on_journey?
       deduct(PENALTY_FARE)
       @journeylog.start_journey(station = nil)
    end
  end

  def on_journey?
    !!journeylog.current_journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
