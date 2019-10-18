require "rspec"
require_relative "../converter"
require_relative "../grader"

describe Grader do
  let (:grader) {Grader.new(Converter.new(Converter::TEMPERATURE))}
  it "passes the temperature examples" do 
    expect(grader.grade("84.2", "Fahrenheit", "543.94", "Rankine")).to eq "CORRECT"
    expect(grader.grade("317.33", "Kelvin", "111.554", "Fahrenheit")).to eq "INCORRECT"
    expect(grader.grade("6.5", "Fahrenheit", "dog", "Rankine")).to eq "INVALID"
  end

  it "passes the volumne examples" do

  end
end
