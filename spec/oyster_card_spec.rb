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

  # describe "#in_journey" do
  #
  #   it { is_expected.to respond_to(:in_journey?) }
  #
  #   it "Initializes with in_journey? as false" do
  #     expect(subject.in_journey?).to eq false
  #   end
  #
  # end

  describe "#touch_in" do

    it { is_expected.to respond_to(:touch_in).with(1).argument}

    # it "Changes in journey to true with touch_in" do
    #   subject.top_up(OysterCard::MIN_TOUCH_IN_LIMIT)
    #   expect{ subject.touch_in(entry_station) }.to change{ subject.in_journey? }.to(true)
    # end

    it "Throws error if card has insufficient balance" do
      expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds!"
    end

    it "Sets the entry_station value" do
      top_up_touch_in
      expect(subject.entry_station).to eq entry_station
    end

  end

  describe "#touch_out" do

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    # it "Changes in journey to false with touch_out" do
    #   top_up_touch_in
    #   expect{ subject.touch_out(exit_station) }.to change{ subject.in_journey? }.to(false)
    # end

    it "Charges the user on touch_out" do
      top_up_touch_in
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -OysterCard::MINIMUM_FARE
    end

    it "Will reset entry_station back to nil" do
      top_up_touch_in_touch_out
      expect(subject.entry_station).to eq nil
    end

    it "Sets a touch_out station value" do
      top_up_touch_in_touch_out
      expect(subject.exit_station).to eq exit_station
    end

  end

   describe "#journey" do

     it { is_expected.to respond_to(:journey_history) }

     it "Expects journey_history to be an empty array" do
       expect(subject.journey_history).to eq []
     end

     it 'will store the journey hash in the jouney_history' do
       top_up_touch_in_touch_out
       expect(subject.journey_history).to eq [{:entry => entry_station, :exit => exit_station}]
     end

     it { is_expected.to respond_to(:journey) }


  end

end
