module Pugnacious
  class Molecule
    attr_accessor :player, :life, :body
    SPEED = 3
    
    def initialize(options = {})
      @player = options[:player]
      @life = 100                       
      @body = Ray::Polygon.rectangle([0,0,4,4], @player.color)      
    end                                                            
    
    def move
      pointer = @player.pointer      
            
      if pointer.x > body.x
        body.x += SPEED
      end                
      
      if pointer.y > body.y
        body.y += SPEED        
      end
      
      if pointer.x < body.x
        body.x -= SPEED
      end
      
      if pointer.y < body.y
        body.y -= SPEED
      end                   
    end           
  end
end