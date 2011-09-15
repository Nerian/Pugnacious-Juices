module Pugnacious
  class Molecule
    attr_accessor :player, :life, :body, :molecules, :pointer
    SPEED = 1
    
    def initialize(options = {})
      @player = options[:player]
      @life = 100                       
      @body = Ray::Polygon.rectangle([0,0,4,4], @player.color)
      @body.pos = options[:pos] unless options[:pos].nil?
      @molecules = options[:molecules]
      @pointer = @player.pointer
    end                                      
                  
    def move                                       
      if pointer_is_down
        try_to_go(:down)
      elsif pointer_is_up 
        try_to_go(:up)
      elsif pointer_is_right 
        try_to_go(:right)
      elsif pointer_is_left 
        try_to_go(:left)
      elsif pointer_is_down_right  
        try_to_go(:down_right)
      elsif pointer_is_up_right 
        try_to_go(:up_right)
      elsif pointer_is_down_left 
        try_to_go(:down_left)
      elsif pointer_is_up_left
        try_to_go(:up_left)
      end
    end
    
    def try_to_go(direction)
      possible_movements = [:up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left, :up ]                                    
        
      intention = possible_movements.index(direction)                                                           
      
      if can_i_move_there?(possible_movements[intention])
        move_there!(possible_movements[intention])   
        
      elsif can_i_move_there?(possible_movements[intention+1])
        move_there!(possible_movements[intention+1])
        
      elsif can_i_move_there?(possible_movements[intention-1])
        move_there!(possible_movements[intention-1])
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
      puts "This is movement: #{movement}"
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