require 'oyster_card'
require 'pry'

describe OysterCard do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  def top_up_touch_in
    subject.top_up(OysterCard::MIN_TOUCH_IN_LIMIT)
    subject.touch_in(entry_station)
  end

  def top_up_touch_in_touch_out
    subject.top_up(OysterCard::MIN_TOUCH_IN_LIMIT)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
  end

  describe "#initialize with balance of 0" do

    it { is_expected.to respond_to(:balance) }

  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "Can top up balance" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "Can't top_up more than LIMIT" do
      max = OysterCard::MAXLIMIT
      subject.top_up(max)
      expect{ subject.top_up 1 }.to raise_error "Error: Card MAX limit is #{OysterCard::MAXLIMIT}"
    end

  end

  describe "#touch_in" do

    it { is_expected.to respond_to(:touch_in).with(1).argument}

    it "Throws error if card has insufficient balance" do
      expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds!"
    end

  end

  describe "#touch_out" do

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it "Charges the user on touch_out" do
      top_up_touch_in
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -OysterCard::MINIMUM_FARE
    end

  end

end
