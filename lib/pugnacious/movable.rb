module Pugnacious
  module Movable 
    
    DIRECTIONS = {:north => [0, -1] , 
      :north_east => [1, -1], 
      :east => [1, 0], 
      :south_east => [1, 1], 
      :south => [0, 1], 
      :south_west => [-1, 1], 
      :west => [-1, 0], 
      :north_west => [-1, -1]}
            
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
       if pointer_is_down then return :south end
       if pointer_is_up then return :north end
       if pointer_is_right then return :east end
       if pointer_is_left then return :west end
       if pointer_is_down_right then return :south_east end
       if pointer_is_up_right then return :north_east end
       if pointer_is_down_left then return :south_west end
       if pointer_is_up_left then return :north_west end
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