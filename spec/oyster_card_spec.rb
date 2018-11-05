require 'oyster_card'
require 'pry'

describe OysterCard do

  let(:card) { OysterCard.new }

  describe "#initialize with balance of 0" do

    it 'responds to #balance' do
      expect(subject).to respond_to :balance
    end

    it 'has a default balance of 0' do
      expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
    end

  end

  describe '#top_up' do

    it 'responds to #top_up' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "Can top up balance" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "Can't top_up more than balance" do
      max = OysterCard::LIMIT
      subject.top_up(max)
      expect{ subject.top_up 1 }.to raise_error "Error: Card limit is #{OysterCard::LIMIT}"
    end

  end

  describe "#Deduct" do

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "Return a value instead of nil" do
      expect(subject.deduct 1).to be_a(Numeric)
    end

    it "Deducts amount spent" do
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end

  end

end
