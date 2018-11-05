class OysterCard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    fail "Error: Card limit is #{LIMIT}" if @balance + amount > 90
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
