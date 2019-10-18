class Chooser
  def initialize(prompt, choices)
    @prompt = prompt
    @choices = choices
  end

  def choose
    puts @prompt
    @choices.each_with_index do |choice, i|
      puts "\t (#{i+1}) #{choice}"
    end

    while (input = gets.chomp ) do
      if input.to_i.to_s == input
        return @choices[input.to_i-1]
      else
        puts "Sorry, please enter a number to choose. "
      end
    end
  end
end