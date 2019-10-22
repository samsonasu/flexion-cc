require "./chooser"
require "./converter"
require "./grader"

require 'active_support'
require 'active_support/core_ext/string'

# Input loop
loop do
  puts "========================="
  puts "Welcome to CovertApp2000!"
  puts "========================="

  conversions = Converter::UnitMap.constants.map(&:to_s).map(&:titlecase)
  domain = Chooser.new("What would you like to convert?", conversions).choose.upcase
  source_unit = Chooser.new("Great!  What unit should we convert #{domain.downcase} from?", Converter::UnitMap.const_get(domain).keys).choose
  
  puts "Initial value in #{source_unit}?"
  source_value = gets.chomp

  target_unit = Chooser.new("Great!  Convert #{source_value} #{source_unit} into what?", Converter::UnitMap.const_get(domain).keys).choose
  
  puts "What was the student's answer?"
  target_answer = gets.chomp

  grader = Grader.new(source_value, source_unit, target_answer, target_unit)
  grade = grader.grade

  puts "\n\n----------------"
  puts "#{target_answer} is #{grade}"
  puts "----------------"
  puts "(correct answer was #{grader.correct_answer})" unless grade == "correct"
  puts "\n\n"
end