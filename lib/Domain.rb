=begin
  TODO: add some variable that will contain predefined tests
  # Look into interfaces in Ruby
=end
class Domain
  
  attr_reader :pop_size
  attr_reader :tests
  attr_reader :maxGen
  attr_reader :tournamentSize
  
  def initialize
    @pop_size = 100
    @maxGen = 3
    @tournamentSize = 5
    populate_tests()
  end
  
  def evaluate_fitness(individual)
    return tests[rand(tests.size)].call(individual)
  end
  
  def populate_tests
    @tests = [ lambda { |ind| puts "Error: No tests defined "} ]
  end
  
end