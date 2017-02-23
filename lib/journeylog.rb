class Journeylog

  attr_reader :current_journey, :entry_station, :exit_station, :history

  def initialize
    @current_journey = nil
    @entry_station = nil
    @exit_station = nil
    @history = []
  end

  def start_journey(station)
    @current_journey = Journey.new
    @entry_station = station
  end

  def finish_journey(station)
    @exit_station = station
    save_history
    reset
  end

  def save_history
    @history << {
      :entry_station => @entry_station,
      :exit_station => @exit_station
      }
  end

  def reset
    @current_journey = nil
    @entry_station = nil
    @exit_station = nil
  end

end
