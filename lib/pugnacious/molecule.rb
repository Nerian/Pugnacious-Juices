module Pugnacious
  class Molecule
    attr_accessor :player, :life, :body, :molecules, :pointer, :position, :game_map        
    SPEED = 1
    DIRECTIONS = {:up => [0, -1] , 
      :up_right => [1, -1], 
      :right => [1, 0], 
      :down_right => [1, 1], 
      :down => [0, 1], 
      :down_left => [-1, 1], 
      :left => [-1, 0], 
      :up_left => [-1, -1]}
    
    
    def initialize(options = {})
      @player = options[:player]
      @game_map = options[:map]                                               
      @position = options[:pos]
      @game_map[@position[0]][@position[1]] = self
      @life = 100                       
      @body = Ray::Polygon.rectangle([0,0,MOLECULE_SIZE,MOLECULE_SIZE], @player.color)
      @body.pos = [@position[0] * MOLECULE_SIZE, @position[1] * MOLECULE_SIZE] || [0, 0]      
      @molecules = options[:molecules]
      @pointer = @player.pointer
      
    end                                      
                  
    def move            
      try_to_go(where_is_the_pointer?) unless where_is_the_pointer? == :here 
    end
    
    def try_to_go(direction)                                                        
      if can_i_move_there?(direction)
        move_there!(direction)           
      end              
    end    
    
    def can_i_move_there?(direction)      
      xw, yw = DIRECTIONS[direction]
      
      x = xw + @position[0]      
      y = yw + @position[1]                  
      
      if @game_map[x][y] == :empty
        return true
      else         
        return false
      end
    end
    
   def where_is_the_pointer?
      if pointer_is_down then return :down end
      if pointer_is_up then return :up end
      if pointer_is_right then return :right end
      if pointer_is_left then return :left end
      if pointer_is_down_right then return :down_right end
      if pointer_is_up_right then return :up_right end
      if pointer_is_down_left then return :down_left end
      if pointer_is_up_left then return :up_left end
      if here then return :here end
    end
    
    #####################
    # Move the molecule
    #####################            
    
    # Move it
    def move_there!(direction) 
      xw, yw =  DIRECTIONS[direction]    
      
      x = (xw + @position[0])
      y = (yw + @position[1])
                  
      @game_map[@position[0]][@position[1]] = :empty
      @game_map[x][y] = self
                
      body.pos = [x*MOLECULE_SIZE, y*MOLECULE_SIZE]
      @position = [x, y]      
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
  
    def here                                       
      @pointer.x == body.x and @pointer.y == body.y
    end
                                   
  end
end