module Pugnacious
  class Molecule
    attr_accessor :player, :life, :body, :molecules, :pointer
    
    SPEED = 1
    POSSIBLE_MOVEMENTS = [:up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left, :up ]
    
    def initialize(options = {})
      @player = options[:player]
      @life = 100                       
      @body = Ray::Polygon.rectangle([0,0,4,4], @player.color)
      @body.pos = options[:pos] || [0, 0]
      @molecules = options[:molecules]
      @pointer = @player.pointer
    end                                      
                  
    def move                   
      try_to_go(where_is_the_pointer?)
    end
    
    def try_to_go(direction)                                                  
      intention = POSSIBLE_MOVEMENTS.index(direction)                                                           
      
      if can_i_move_there?(POSSIBLE_MOVEMENTS[intention])
        move_there!(POSSIBLE_MOVEMENTS[intention])   
        
      elsif can_i_move_there?(POSSIBLE_MOVEMENTS[intention+1])
        move_there!(POSSIBLE_MOVEMENTS[intention+1])
        
      elsif can_i_move_there?(POSSIBLE_MOVEMENTS[intention-1])
        move_there!(POSSIBLE_MOVEMENTS[intention-1])
      end              
    end    
    
    def can_i_move_there?(direction) 
      
      pos = move_there(direction)
      does_this = Ray::Rect.new(pos.x, pos.y, 4, 4)
            
      can_i = @molecules.any? do |m|
        if m != self
          with_this = Ray::Rect.new(m.body.pos.x, m.body.pos.y, 4, 4)
          does_this.collide?(with_this)
        else
          false
        end
      end     
      
      return !can_i
    end       
    
    
    #####################
    # Move the molecule
    #####################    
        
    # Simulates the movement
    def move_there(movement)  
      self.send(:"move_#{movement}")
    end
    
    # Move it
    def move_there!(movement)
      pos = self.send(:"move_#{movement}")
      body.pos = pos
    end
    
    def move_up
      pos = body.pos
      pos.y -= SPEED
      pos
    end   
    
    def move_down
      pos = body.pos
      pos.y += SPEED      
      pos
    end     
    
    def move_right                     
      pos = body.pos
      pos.x += SPEED
      pos
    end      
    
    def move_left      
      pos = body.pos
      pos.x -= SPEED
      pos
    end     
    
    def move_up_right                  
      pos = body.pos
      pos.y -= SPEED
      pos.x += SPEED                      
      pos
    end         
    
    def move_up_left
      pos = body.pos
      pos.x -= SPEED
      pos.y -= SPEED        
      pos
    end        
    
    def move_down_right
      pos = body.pos
      pos.y += SPEED
      pos.x += SPEED
      pos
    end           
    
    def move_down_left    
      pos = body.pos
      pos.x -= SPEED
      pos.y += SPEED              
      pos
    end            
               
    #######################
    # Where is the pointer?
    #######################    
    
    def where_is_the_pointer?
      if pointer_is_down then return :down end
      if pointer_is_up then return :up end
      if pointer_is_right then return :right end
      if pointer_is_left then return :left end
      if pointer_is_down_right then return :down_right end
      if pointer_is_up_right then return :up_right end
      if pointer_is_down_left then return :down_left end
      if pointer_is_up_left then return :up_left end
    end
    
    def pointer_is_down      
      @pointer.x == body.x and @pointer.y > body.y      
    end
    
    def pointer_is_up
      @pointer.x == body.x and @pointer.y < body.y      
    end
    
    def pointer_is_right
      @pointer.x > body.x and @pointer.y == body.y      
    end
    
    def pointer_is_left
      @pointer.x < body.x and @pointer.y == body.y      
    end   
    
    def pointer_is_down_right 
      @pointer.x > body.x and @pointer.y > body.y      
    end     
    
    def pointer_is_up_right
      @pointer.x > body.x and @pointer.y < body.y      
    end
    
    def pointer_is_down_left
      @pointer.x < body.x and @pointer.y > body.y
    end  
    
    def pointer_is_up_left
      @pointer.x < body.x and @pointer.y < body.y
    end
    
        
  end
end