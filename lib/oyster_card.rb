class OysterCard

  attr_reader :balance, :in_journey

  DEFAULT_BALANCE = 0
  MAXLIMIT = 90
  MIN_TOUCH_IN_LIMIT = 1
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Error: Card MAX limit is #{MAXLIMIT}" if @balance + amount > MAXLIMIT
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient funds!" if @balance < 1
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
