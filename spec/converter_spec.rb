require 'rspec'
require_relative '../converter'

describe Converter do
  describe "Sets the unit_map correctly for different units" do 

    it "Chooses temperature map for temperature units" do
      expect(Converter.for_units("Kelvin", "Fahrenheit").unit_map).to eq Converter::UnitMap::TEMPERATURE
    end

    it "Chooses volumne for volumne units" do 
      expect(Converter.for_units("Cups", "gallons").unit_map).to eq Converter::UnitMap::VOLUME
    end

    it "Raises an exception if there's no unit map" do
      expect { Converter.for_units("dog", "cat") }.to raise_exception
    end
  end

  describe "Converting Temperatures" do
    let(:converter) do 
      Converter.new(Converter::UnitMap::TEMPERATURE)
    end

    it "converts Kevlin to Celsius" do 
      expect(converter.convert(1, "Kelvin", "Celsius")).to eq -272.15
    end
    it "converts Fahrenheit to Celsius" do
      expect(converter.convert(32, "Fahrenheit", "Celsius")).to eq 0
    end

    it "converts Fahrenheit to Rankine" do
      expect(converter.convert(84.2, "Fahrenheit", "Rankine")).to eq 543.87
    end

  end

  describe "Converting Volumes" do
    let(:converter) do 
      Converter.new(Converter::UnitMap::VOLUME)
    end
    it "converts cups to liters" do 
      expect(converter.convert(1, "Cups", "Liters")).to be_within(0.01).of 0.236588
    end
    it "converts tablespoons to liters" do 
      expect(converter.convert(5, "Tablespoons", "Liters")).to be_within(0.01).of 0.0739338
    end

    it "converts gallons to cubic inches" do 
      expect(converter.convert(18, "Gallons", "Cubic Inches")).to be_within(1).of 4158
    end

    it "converts cubic feet to cubic inches" do 
      expect(converter.convert(3, "Cubic Feet", "Cubic Inches")).to be_within(1).of 5184
    end
  end
end