require_relative "station"
require_relative "oyster_card"

class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @journey_his = []
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def start(station)
    @entry = station
    @journey_his << @entry_station
  end

  def finish(station)
    @exit = station
    @journey_his << @exit_station
  end


  private

  def in_journey?
    @entry && !@exit
  end

  def complete?
    @entry && @exit
  end

end
