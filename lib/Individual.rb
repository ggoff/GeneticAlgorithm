=begin
  An individual member of the population. Contains the genetic code.
=end
class Individual
  attr_reader :genome
  attr_reader :fitness
  
  def initialize()
    @genome = [ rand(2), rand(2), rand(2) ]
    @fitness = 0 #score out of 100 percent
  end
  
  def setFitness(newfit)
    @fitness = newfit
  end
  
  def setGenome(newGenome)
    @genome = newGenome
  end
  
  def getGenomeIndex(index)
    return @genome[index]
  end
  
end 