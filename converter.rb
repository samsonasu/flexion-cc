class Converter

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
  
  def convert(value, source_unit, target_unit) 
    source_true = @unit_map[source_unit][0].call(value.to_f)
    target = @unit_map[target_unit][1].call(source_true)

    puts "CONVERT #{value} #{source_unit} (#{source_true}) to #{target_unit} = #{target}"
    return target
  end
  
end