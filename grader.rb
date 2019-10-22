class Grader
  attr_accessor :source, :source_unit, :target, :target_unit
  def initialize(source, source_unit, target, target_unit)  
    @source = source
    @source_unit = source_unit
    @target = target
    @target_unit = target_unit
  end

  def converter
    @converter ||= Converter.for_units(@source_unit, @target_unit)
  end

  def grade
    if @target.to_f.to_s != @target && @target.to_f.to_i.to_s != @target
      puts "Student answer was not a number"
      return "incorrect"
    end
    target_value = @target.to_f    
    target_true = converter.convert(@source_value)
        
    if @source_value.to_f - target_true <= 0.1
      "correct"
    else
      "incorrect"
    end

  rescue StandardError => ex
    STDERR.puts ex.message
    "invalid"
  end
end