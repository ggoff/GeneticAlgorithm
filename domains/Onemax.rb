require_relative File.path(File.join(LIB, "Domain"))

=begin
  def evaluate_fitness(individual)
    n = 0
    (0..(individual.genome.size-1)).each do |i| 
      n += individual.genome[i]
    end
    puts ((n/individual.genome.length) * 100)
    return (n/individual.genome.length) * 100
  end  
=end

class Onemax < Domain
  
  def initialize
    super
  end
  
  def evaluate_fitness(individual)
    super(individual)
  end

  def populate_tests
    @tests = [( lambda { |ind|
      (ind.genome.reduce(:+)/ind.genome.size)*100
      } )]
  end
  
end