class OysterCard

  attr_reader :balance, :in_journey

  DEFAULT_BALANCE = 0
  MAXLIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Error: Card MAX limit is #{MAXLIMIT}" if @balance + amount > 90
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "You can't touch in twice!" if @in_journey == true
    @in_journey = true
  end

  def touch_out
    fail "You can't touch out twice!" if @in_journey == false
    @in_journey = false
  end

end
