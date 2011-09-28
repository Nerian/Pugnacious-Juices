require './lib/pugnacious/version'

Gem::Specification.new do |s|
  s.name          = 'pugnacious_juices'
  s.version       = Pugnacious::VERSION
  s.date          = '2011-09-14'
  s.summary       = "Two or more fluids fight for total dominance "
  s.description   = "It is a clone of Liquid Wars."
  s.authors       = ["Gonzalo Rodriguez-Baltanas Diaz"]
  s.email         = 'siotopo@gmail.com'
  s.files         = Dir['lib/**/*.rb', 'bin/*']
  s.bindir        = 'bin'                                           
  s.executables   << 'pugnacious'
  s.require_paths = ["lib"]  
  s.homepage      = 'https://github.com/Nerian/Pugnacious-Juices'   
  s.add_runtime_dependency 'ray'
end