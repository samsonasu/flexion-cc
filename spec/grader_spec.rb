require 'rspec'
require_relative '../grader'

describe Grader do

  describe "converter" do
    let(:grader) { Grader.new("1", "Fahrenheit", "1", "Celsius") }
    it "gets the correct converter for temp" do
      expect(grader.converter.unit_map).to eq Converter::TEMPERATURE
    end
  end
  
  describe "Coding challenge tests" do
    
    # from the table in the coding challenge
    [
      { in: "84.2", in_unit: "Fahrenheit", out: "543.94", out_unit: "Rankine", result: "correct" },
      { in: "317.33", in_unit: "Kelvin", out_unit: "Fahrenheit", out: "111.554", result: "incorrect"}, 
      { in: "25.6", in_unit: "Cups", out_unit:  "Liters", out:  "6.1", result: "correct"},
      { in: "73.12", in_unit: "Gallons", out_unit: "Kelvin", out: "19.4", result: "invalid"}, 
      { in: "6.5", in_unit: "Fahrenheit", out_unit: "Rankine", out: "dog", result: "incorrect"},
      { in: "136.1", in_unit: "dog ", out_unit: "Celsius", out: "45.32", result: "invalid" }
    ].each_with_index do |ex, i|
      
      it "Scores example #{i+1} (#{ex[:in]} #{ex[:in_unit]} => #{ex[:out]} #{ex[:out_unit]}) as '#{ex[:result]}'" do
        grader = Grader.new(ex[:in], ex[:in_unit], ex[:out], ex[:out_unit])
        expect(grader.grade).to eq ex[:result]
      end
    end
  end
end