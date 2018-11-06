require 'oyster_card'
require 'pry'

describe OysterCard do

  let(:station) { double :station }

  describe "#initialize with balance of 0" do

    it { is_expected.to respond_to(:balance) }

    it 'has a default balance of 0' do
      expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
    end

    it { is_expected.to respond_to(:entry_station) }

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

  # Test for deduct method is invalid due to it becoming a private method
  # describe "#Deduct" do
  #
  #   it { is_expected.to respond_to(:deduct).with(1).argument }
  #
  #   it "Deducts amount spent" do
  #     expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
  #   end
  #
  # end

  describe "#in_journey" do

    it { is_expected.to respond_to(:in_journey?) }

    it "Initializes with in_journey? as false" do
      expect(subject.in_journey?).to eq false
    end

  end

  describe "#touch_in" do

    it { is_expected.to respond_to(:touch_in).with(1).argument}

    it "Changes in journey to true with touch_in" do
      subject.top_up(OysterCard::MIN_TOUCH_IN_LIMIT)
      expect{ subject.touch_in(station) }.to change{ subject.in_journey? }.to(true)
    end

    it "Throws error if card has insufficient balance" do
      expect{ subject.touch_in(station) }.to raise_error "Insufficient funds!"
    end

    it "Sets the entry_station value" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

  end

  describe "#touch_out" do

    it { is_expected.to respond_to(:touch_out) }

    it "Changes in journey to false with touch_out" do
      subject.top_up(OysterCard::MIN_TOUCH_IN_LIMIT)
      subject.touch_in(station)
      expect{ subject.touch_out }.to change{ subject.in_journey? }.to(false)
    end

    it "Charges the user on touch_out" do
      expect{ subject.touch_out }.to change{ subject.balance }.by -OysterCard::MINIMUM_FARE
    end

    it "Will reset entry_station back to nil" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end

  end

end
