require 'journey'

describe Journey do

  describe "#Respondents" do

    it { is_expected.to respond_to(:fare) }

    it { is_expected.to respond_to(:start).with(1).argument }

    it { is_expected.to respond_to(:finish).with(1).argument }

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

  # it "Changes in journey to true with touch_in" do
  #   subject.top_up(OysterCard::MIN_TOUCH_IN_LIMIT)
  #   expect{ subject.touch_in(entry_station) }.to change{ subject.in_journey? }.to(true)
  # end

  # it "Changes in journey to false with touch_out" do
  #   top_up_touch_in
  #   expect{ subject.touch_out(exit_station) }.to change{ subject.in_journey? }.to(false)
  # end


end
