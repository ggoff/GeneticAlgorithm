=begin
  
=end
require_relative "Individual"

class Population
 
  @pop_accuracy = 0
  
  def initialize(psize)
    @pop_size = psize
    @population = Array.new(@pop_size)
    @generationNum = 0
    (0..(@pop_size-1)).each do |i| 
      @population[i] = Individual.new()
    end
    updatePopulation()
  end
  
  def updatePopulation
    updatePopulationAccuracy()
    puts "updatingPopulation"
    puts "#{@population.size}"
    @population = @population.sort { |x,y| y.fitness <=> x.fitness }
    BreedPopulation()
  end
  
  def BreedPopulation
    @parents = @population.clone()
    @children = Array.new()
    (0..@population.size/2 -1).each do
      @parents.compact
      #puts "ParentPoolSize #{@parents.size}"
      #index1 = rand(0..@parents.size/2)
      #index2 = rand(@parents.size/2..@parents.size-1)
      #puts "Index1 #{index1}, Index2 #{index2}"
      #ind1 = @parents[index1]
      #ind2 = @parents[index2]
      #puts "Parent1 #{ind1}"
      #puts "Parent2 #{ind2}"
      ind1 = Tournament()
      #@parents.delete(ind1)
      ind2 = Tournament()
      #@parents.delete(ind2)
      @childPair = Breed(ind1, ind2)
      @children.push(@childPair[0])
      @children.push(@childPair[1])
    end
    @population = @children.clone()
    puts "Generation: #{@generationNum}"
    @generationNum = @generationNum + 1
    if @generationNum < $DOMAIN.maxGen
      updatePopulation()
    else
      updatePopulationAccuracy()
     end
  end
  
  def Tournament
    @pool = @parents.clone
    #puts("#{@pool.size}     #{@parents.size}")
    @contestants = Array.new()
    (0..$DOMAIN.tournamentSize-1).each do |i|
      @contestants.push(@pool[rand(@pool.size)])
      @pool.delete(@contestants[@contestants.size-1])
      @pool.compact()
    end
    #puts("#{@pool.size}   #{@contestants.size}    #{@contestants[0]}")
    @contestants = @contestants.sort { |x,y| y.fitness <=> x.fitness }
    return @contestants[0]
  end
  
  def Breed(ind1, ind2)
    @child1 = Individual.new()
    @child2 = Individual.new()
    
    @genomeCrux = rand(ind1.genome.size)
    
    @genome1 = Array.new()
    @genome2 = Array.new()
    
    #puts "Individual: #{ind1}"
    #puts "Genome: #{ind1.genome}"
    #puts "Individual2: #{ind2}"
    (0..ind1.genome.size-1).each do |i|
      if i < @genomeCrux
        @genome1.push(ind1.getGenomeIndex(i))
        @genome2.push(ind2.getGenomeIndex(i))
      else
        @genome1.push(ind2.getGenomeIndex(i))
        @genome2.push(ind1.getGenomeIndex(i))
      end   
    end
    
    @child1.setGenome(@genome1)
    @child2.setGenome(@genome2)
    
    return [@child1, @child2]
  end
  
  def updatePopulationAccuracy
    total = 0
    temp = 0
    (0..(@population.size-1)).each do |i| 
      temp = $DOMAIN.evaluate_fitness(@population[i]) 
      @population[i].setFitness( temp )
      total += temp
    end
    @pop_accuracy = total/@population.size
    puts getPopulationAccuracy
  end
  
  def getPopulationAccuracy
    return "Population Accuracy: #{@pop_accuracy}%"
  end
  
  
end