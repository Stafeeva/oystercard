class Journeylog

  attr_reader :entry_station, :exit_station, :history

  def initialize
    @entry_station = nil
    @exit_station = nil
    @history = []
  end

  def start_journey(station)
    @entry_station = station
  end

  def finish_journey(station)
    @exit_station = station
    save_history
  end

  def save_history
    @history << {
      :entry_station => @entry_station,
      :exit_station => @exit_station
      }
  end

  def reset
    @entry_station = nil
    @exit_station = nil
  end

end
