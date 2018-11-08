require "station"

describe Station do

  describe "#initialize" do

    let(:station) {Station.new("Name", 1)}

    it "Creates a name and zone upon initialize" do
      expect(station.name).to eq "Name"
      expect(station.zone).to eq 1
    end

  end

end
