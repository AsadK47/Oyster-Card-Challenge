require_relative "station"
require_relative "oyster_card"

class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  private

  def in_journey?
    @entry_station && !@exit_station
  end

  def complete?
    @entry_station && @exit_station
  end

end
