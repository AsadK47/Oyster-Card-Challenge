class OysterCard

  attr_reader :balance, :entry_station, :exit_station

  DEFAULT_BALANCE = 0
  MAXLIMIT = 90
  MIN_TOUCH_IN_LIMIT = 1
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE, entry_station = nil, exit_station = nil)
    @balance = balance
    @entry_station = entry_station
    @exit_station = exit_station
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
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
