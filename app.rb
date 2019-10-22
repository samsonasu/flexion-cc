require "./chooser"
require "./converter"
require "./grader"

# Input loop

puts "Welcome to CovertApp2000!"

# lambdas convert to the [0] value
conversions = {
  "Temperature" => Converter::TEMPERATURE,
  "Volume" => Converter::VOLUME
}

domain = Chooser.new("What would you like to convert?", conversions.keys ).choose
converter = Converter.new(conversions[domain])

source_unit = Chooser.new("Great!  What unit should we convert #{domain.downcase} from?", conversions[domain].keys).choose
puts "Initial value in #{source_unit}?"
source_value = gets.chomp

target_unit = Chooser.new("Great!  Convert #{source_value} #{source_unit} into what?", conversions[domain].keys).choose
puts "What was the student's answer?"
target_answer = gets.chomp

grader = Grader.new(converter)
puts grader.grade(source_value, source_unit, target_answer, target_unit)
