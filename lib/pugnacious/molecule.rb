module Pugnacious
  class Molecule
    attr_accessor :player, :life, :body
    SPEED = 3
    
    def initialize(options = {})
      @player = options[:player]
      @life = 100                       
      @body = Ray::Polygon.rectangle([10,10,4,4], @player.color)      
    end                                                            
    
    def move
      pointer = @player.pointer  
      
      if pointer.x == body.x and pointer.y > body.y
        #go_up
      end                                         
        
      if pointer.x > body.x and pointer.y > body.y          
        #go_up_and_right
      end                  
                                
      if pointer.x > body.x and pointer.y == body.y          
        #go_right
      end                       
      
      if pointer.x < body.x and pointer.y < body.y          
        #go_down_and_right
      end
      
      if pointer.x == body.x and pointer.y < body.y          
        #go_down        
      end
      
      if pointer.x < body.x and pointer.y < body.y          
        #go_down_and_left        
      end
      
      if pointer.x < body.x and pointer.y == body.y          
        #go_left
      end
      
      if pointer.x < body.x and pointer.y > body.y          
        #go_up_and_left
      end
    end           
  end
end