class Grader
  attr_accessor :source, :source_unit, :target, :target_unit
  attr_reader :correct_answer
  def initialize(source, source_unit, target, target_unit)  
    @source = source
    @source_unit = source_unit
    @target = target
    @target_unit = target_unit
  end

  def grade
    return "incorrect" unless target_is_number?
      
    @correct_answer = converter.convert(@source)    
    if @target.to_f.round(1) == @correct_answer.round(1)
      "correct"
    else
      "incorrect"
    end

  rescue StandardError => ex
    STDERR.puts ex.message
    "invalid"
  end

  def converter
    @converter ||= Converter.for_units(@source_unit, @target_unit)
  end

  private

  def target_is_number?
    @target.to_f.to_s == @target || @target.to_f.to_i.to_s == @target
  end


end