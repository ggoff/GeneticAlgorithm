=begin
  
=end

LIB = File.dirname(__FILE__) + "/lib".freeze
require_relative File.path(File.join(LIB, "Population"))
require_relative File.path(File.join(LIB, "Domain"))

#=> String : Users domain choice
def prompt
  # Begin user prompt
  print "Choose a domain: "
  domains = []
  
  # Loop through each file and populate domain options
  Dir["domains/*"].each {|file| domains << file.split('/').last.split('.rb').first }
  #print domains.length
  #keys = {1: Onemax.new }
  
  domains.each_with_index {|f,i| puts "#{i+1}: #{f}" }
  return domains[gets.chomp.to_i-1] # Return user's choice
end

userfilename = prompt
DOMAINPATH = File.dirname(__FILE__) + "/domains"
require_relative File.path(File.join(DOMAINPATH, userfilename))

$DOMAIN = Object.const_get(userfilename).new
# puts domain.pop_size
# Return Population
Population.new($DOMAIN.pop_size)
