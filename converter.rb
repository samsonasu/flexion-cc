require 'active_support'
require 'active_support/core_ext/string'

class Converter
  attr_accessor :source_unit, :target_unit
  attr_reader :unit_map

  TEMPERATURE = {
    "Kelvin" => [
      lambda { |v|  v },
      lambda { |v|  v }
    ],
    "Celsius" => [
      lambda { |v| v + 273.15},
      lambda { |v| v - 273.15}
    ],
    "Fahrenheit" => [
      lambda { |v| (v - 32.0) * 5.0 / 9.0 + 273.15},
      lambda { |v| (v - 273.15) * 5.0 / 9.0 + 32.0 }
    ],
    "Rankine" => [
      lambda { |v| v * 0.555556 },
      lambda { |v| v * 1.8 }
    ]
  }

  VOLUME = {
    "Liters" => 1, 
    "Tablespoons" => 2,
    "Cubic Inches" => 3, 
    "Cups" => 4, 
    "Cubic Feet" => 5,
    "Gallons" => 6
  }

  VOLUME_INVERSE = {
    "Liters" => 1, 
    "Tablespoons" => 2,
    "Cubic Inches" => 3, 
    "Cups" => 4, 
    "Cubic Feet" => 5,
    "Gallons" => 6
  }

  def initialize(unit_map)
    @unit_map = unit_map
  end

  def self.for_units(source_unit, target_unit)
    unit_map = nil
    [TEMPERATURE, VOLUME].each do |map|
      if map.keys.include?(source_unit.titlecase) && map.keys.include?(target_unit.titlecase)
        unit_map = map
      end
    end
    
    raise "No Unit map found for #{source_unit} => #{target_unit}" if unit_map.nil?
    converter = Converter.new(unit_map)
    converter.source_unit = source_unit
    converter.target_unit = target_unit

    return converter
  end
  
  def convert(value, source_unit=nil, target_unit=nil) 
    @source_unit = source_unit unless source_unit.nil?
    @target_unit = target_unit unless target_unit.nil?

    source_true = unit_map[@source_unit][0].call(value.to_f)
    target = unit_map[@target_unit][1].call(source_true)

    puts "CONVERT #{value} #{@source_unit} (#{source_true}) to #{@target_unit} = #{target}"
    return target
  end
  
end