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

  end

end
