require 'rspec'
require_relative '../converter'

describe Converter do
  describe "Sets the unit_map correctly for different units" do 

    it "Chooses temperature map for temperature units" do
      expect(Converter.for_units("Kelvin", "Fahrenheit").unit_map).to eq Converter::TEMPERATURE
    end

    it "Chooses volumne for volumne units" do 
      expect(Converter.for_units("Cups", "gallons").unit_map).to eq Converter::VOLUME
    end

    it "Raises an exception if there's no unit map" do
      expect { Converter.for_units("dog", "cat") }.to raise_exception
    end
  end

  describe "Converting Temperatures" do
    let(:converter) do 
      Converter.new(Converter::TEMPERATURE)
    end

    it "converts temperatures" do 
      expect(converter.convert(1, "Kelvin", "Celsius")).to eq -272.15
      expect(converter.convert(32, "Fahrenheit", "Celsius")).to eq 0
      expect(converter.convert(84.2, "Fahrenheit", "Rankine")).to eq 543.87
    end
  end
end