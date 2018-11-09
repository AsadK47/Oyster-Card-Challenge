require_relative "journey"

class OysterCard

  MAXLIMIT = 90
  MIN_TOUCH_IN_LIMIT = 1
  MINIMUM_FARE = 1

  attr_reader :balance, :journey_his, :journey_current

  def initialize(journey_his = [], journey_current = Journey.new)
    @balance = 0
    @journey_his = journey_his
    @journey_current = journey_current
  end

  def top_up(amount)
    fail "Error: Card MAX limit is #{MAXLIMIT}" if @balance + amount > MAXLIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds!" if @balance < 1
    @journey_current.start(station)
    @journey_current.fare
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey_current.finish(station)
    @journey_current.fare
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
