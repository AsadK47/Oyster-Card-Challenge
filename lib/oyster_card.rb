class OysterCard

  DEFAULT_BALANCE = 0
  MAXLIMIT = 90
  MIN_TOUCH_IN_LIMIT = 1
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :journey_history, :journey

  def initialize(balance = DEFAULT_BALANCE, journey_history = [], journey = {:entry => nil, :exit => nil})
    @balance = balance
    @entry_station = entry_station
    @exit_station = exit_station
    @journey_history = journey_history
    @journey = journey
  end

  def top_up(amount)
    fail "Error: Card MAX limit is #{MAXLIMIT}" if @balance + amount > MAXLIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "Insufficient funds!" if @balance < 1
    @entry_station = station
    @journey[:entry] = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = station
    @journey[:exit] = station
    @journey_history << @journey
    @journey = {}
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
