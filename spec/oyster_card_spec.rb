require 'oyster_card'
require 'pry'

describe OysterCard do

  let(:card) { OysterCard.new }

  describe "#initialize with balance of 0" do

    it { is_expected.to respond_to(:balance) }

    it 'has a default balance of 0' do
      expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
    end

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

  describe "#Deduct" do

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "Deducts amount spent" do
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end

  end

  describe "#in_journey" do

    it { is_expected.to respond_to(:in_journey?) }

    it "Initializes with in_journey? as false" do
      expect(card.in_journey?).to eq false
    end

  end

  describe "#touch_in" do

    it { is_expected.to respond_to(:touch_in)}

    it "Changes the state of in_journey? to true" do
      expect{ card.touch_in }.to change{ card.in_journey? }.to(true)
    end

    it "Checks if card is already in_journey and prevents double touch" do
      card.touch_in
      expect{ card.touch_in }.to raise_error "You can't touch in twice!"
    end

  end

  describe "#touch_out" do

    it { is_expected.to respond_to(:touch_out) }

    it "Changes the state of in_journey? to false" do
      card.touch_in
      expect { card.touch_out }.to change{ card.in_journey? }.to(false)
    end

    it "Checks if card is already out and prevents touch_out" do
      expect{ card.touch_out }.to raise_error "You can't touch out twice!"
    end

  end

end
