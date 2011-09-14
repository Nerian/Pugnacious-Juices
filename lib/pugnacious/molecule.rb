module Pugnacious
  class Molecule
    attr_accessor :player, :life, :point
    SPEED = 3
    
    def initialize(options = {})
      @player = options[:player]
      @life = 100                       
      @point = Ray::Polygon.rectangle([10,10,11,11], @player.color)      
    end                                                            
    
    def move
      
    end    
  end
end