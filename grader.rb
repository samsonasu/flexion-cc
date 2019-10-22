class Grader
  attr_accessor :source, :source_unit, :target, :target_unit
  def initialize(source, source_unit, target, target_unit)  
    @source = source
    @source_unit = source_unit
    @target = target
    @target_unit = target_unit
  end


  def converter
    Converter.for_units(@source_unit, @target_unit)
  end

  def blah
    if target_answer.to_f.to_s != target_answer && target_answer.to_f.to_i.to_s != target_answer
      puts "Student answer was INVALID"
      return "INVALID"
    end
    target_value = target_answer.to_f
    
    target_true = @converter.convert(source_value, source_unit, target_unit)
    # correct, incorrect, or invalid
    # source_true = conversions[domain][source_unit].call(source_value.to_f)
    # target_true = conversions[domain][target_unit].call(source_value.to_f)
    
    puts "STUDENT said #{target_value} == #{target_true} and that is:\n"
    
    if source_value.to_f - target_true <= 0.1
      "CORRECT"
    else
      "INCORRECT"
    end
    
  end
end