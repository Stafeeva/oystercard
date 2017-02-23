class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(station)
    @entry_station = station
  end

  def finish_journey(station)
    @exit_station = station
  end

  def save_history(oystercard)
    oystercard.history << {
      :entry_station => @entry_station,
      :exit_station => @exit_station
      }
  end

  def fare
    #fare
  end

end
