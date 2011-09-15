module Pugnacious
  class Molecule
    attr_accessor :player, :life, :body
    SPEED = 3
    
    def initialize(options = {})
      @player = options[:player]
      @life = 100                       
      @body = Ray::Polygon.rectangle([0,0,4,4], @player.color)      
    end       
    
    def move_up       
      body.y -= SPEED      
    end   
    
    def move_down         
      body.y += SPEED      
    end     
    
    def move_right
      body.x += SPEED
    end      
    
    def move_left
      body.x -= SPEED
    end     
    
    def move_up_right
      body.y -= SPEED
      body.x += SPEED
    end         
    
    def move_up_left
      body.y -= SPEED
      body.x -= SPEED      
    end        
    
    def move_down_right   
      body.y += SPEED
      body.x += SPEED      
    end           
    
    def move_down_left    
      body.y += SPEED
      body.x -= SPEED      
    end      
    
    def move
      pointer = @player.pointer  
      
      if pointer.x == body.x and pointer.y > body.y
        move_down
      end
      
      if pointer.x == body.x and pointer.y < body.y
        move_up
      end
      
      if pointer.x > body.x and pointer.y == body.y
        move_right
      end    
      
      if pointer.x < body.x and pointer.y == body.y
        move_left
      end
            
      if pointer.x > body.x and pointer.y > body.y
        move_down_right        
      end   
      
      if pointer.x > body.x and pointer.y < body.y
        move_up_right
      end                
      
      if pointer.x < body.x and pointer.y > body.y
        move_down_left
      end 
      
      if pointer.x < body.x and pointer.y < body.y
        move_up_left
      end       
    end           
  end
end