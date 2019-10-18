require 'rspec'
require_relative '../converter'

describe Converter do
  
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