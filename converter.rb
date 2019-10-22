require 'active_support'
require 'active_support/core_ext/string'

class Converter
  attr_accessor :source_unit, :target_unit
  attr_reader :unit_map

  # These maps provide lambdas that convert to and from the base unit
  # First lambda is how to convert *to* the base unit
  # Second lambda is the inverse, converting *from* the base unit
  module UnitMap
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
      "Liters" => [
        lambda { |v| v}, 
        lambda { |v| v}
      ], 
      "Tablespoons" => [
        lambda { |v| v / 67.628 },
        lambda { |v| v * 67.628 }
      ],
      "Cubic Inches" => [
        lambda { |v| v /  61.024 },
        lambda { |v| v *  61.024 }
      ],
      "Cups" => [
        lambda { |v| v / 4.227 },
        lambda { |v| v * 4.227 }
      ], 
      "Cubic Feet" => [
        lambda { |v| v * 28.317 },
        lambda { |v| v / 28.317 }
      ], 
      "Gallons" => [
        lambda { |v| v * 3.78541 },
        lambda { |v| v / 3.78541 }
      ]
    }
  end

  def initialize(unit_map)
    @unit_map = unit_map
  end

  # TODO: make this the only constructor
  def self.for_units(source_unit, target_unit)
    unit_map = common_unit_map(source_unit, target_unit)
    raise "No Unit map found for #{source_unit} => #{target_unit}" if unit_map.nil?
    return Converter.configured(unit_map, source_unit, target_unit)
  end

  def convert(value, source_unit=nil, target_unit=nil) 
    @source_unit = source_unit unless source_unit.nil?
    @target_unit = target_unit unless target_unit.nil?

    value_in_base_units = unit_map[@source_unit][0].call(value.to_f)
    value_in_target_units = unit_map[@target_unit][1].call(value_in_base_units)
    
    return value_in_target_units
  end

  private

  def self.common_unit_map(a, b) 
    unit_map = nil
    [UnitMap::TEMPERATURE, UnitMap::VOLUME].each do |map|
      if map.keys.include?(a.titlecase) && map.keys.include?(b.titlecase)
        unit_map = map
      end
    end
    unit_map
  end

  def self.configured(unit_map, source_unit, target_unit) 
    converter = Converter.new(unit_map)
    converter.source_unit = source_unit
    converter.target_unit = target_unit
    converter
  end
  
end