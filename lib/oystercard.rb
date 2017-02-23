require_relative 'Journey'
require_relative 'Journeylog'

class Oystercard
  attr_reader :balance, :journeylog, :current_journey

  MAX_MONEY = 90
  MIN_MONEY = 1
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @current_journey = nil
    @journeylog = Journeylog.new
  end

  def top_up(value)
    fail "Your balance cannot go over £#{Oystercard::MAX_MONEY}." if @balance + value > MAX_MONEY
    @balance += value
  end

  def touch_in(station)
    check_when_touch_in
    @current_journey = Journey.new
    @journeylog.start_journey(station)
  end

  def check_when_touch_in
    deduct(PENALTY_FARE) if on_journey?
    fail "min. balance of £#{Oystercard::MIN_MONEY} not reached" if @balance <= MIN_MONEY
  end

  def touch_out(station)
    deduct_fare
    @journeylog.finish_journey(station)
    @current_journey = nil
  end

  def deduct_fare
    if !on_journey?
       fare = MINIMUM_FARE
       @current_journey =  Journey.new
    else
      fare = Journey.new.fare
    end
    deduct(fare)
  end

  def on_journey?
    !!@current_journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
