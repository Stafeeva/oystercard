class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1

  def initialize(station)
    @entry_station = station
    @exit_station = nil
  end

  def finish_journey(station, oystercard)
    @exit_station = station
    oystercard.history << {
      :entry_station => @entry_station,
      :exit_station => @exit_station
      }
  end

  def fare
    #fare
  end

end
