module Pugnacious
  class Molecule
    attr_accessor :player, :life, :body, :molecules
    SPEED = 1
    
    def initialize(options = {})
      @player = options[:player]
      @life = 100                       
      @body = Ray::Polygon.rectangle([0,0,4,4], @player.color)
      @body.pos = options[:pos] unless options[:pos].nil?
      @molecules = options[:molecules]
    end       
             
    def move
      pointer = @player.pointer                  
            
      if (pointer.x == body.x and pointer.y > body.y) 
        move_down 
      elsif (pointer.x == body.x and pointer.y < body.y) 
        move_up                 
      elsif (pointer.x > body.x and pointer.y == body.y) 
        move_right       
      elsif (pointer.x < body.x and pointer.y == body.y) 
        move_left                     
      elsif (pointer.x > body.x and pointer.y > body.y) 
        move_down_right      
      elsif (pointer.x > body.x and pointer.y < body.y) 
        move_up_right       
      elsif (pointer.x < body.x and pointer.y > body.y) 
        move_down_left       
      elsif (pointer.x < body.x and pointer.y < body.y) 
        move_up_left 
      end
    end
    
    def can_i_move_there?(pos = {})
      x = pos[:x] || body.pos.x
      y = pos[:y] || body.pos.y
      does_this = Ray::Rect.new(x, y, 4, 4)
            
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
    
    def move_up
      if can_i_move_there?(y: body.pos.y -= SPEED)       
        body.y -= SPEED
      end            
    end   
    
    def move_down         
      if can_i_move_there?(y: body.pos.y += SPEED)       
        body.y += SPEED
      end                        
    end     
    
    def move_right               
      if can_i_move_there?(x: body.pos.x += SPEED)       
        body.x += SPEED
      end          
    end      
    
    def move_left
      if can_i_move_there?(x: body.pos.x -= SPEED)       
        body.x -= SPEED
      end
    end     
    
    def move_up_right            
      if can_i_move_there?(x: body.pos.x += SPEED, y:body.pos.y -= SPEED)
        body.y -= SPEED
        body.x += SPEED                
      end
    end         
    
    def move_up_left
      if can_i_move_there?(x: body.pos.x -= SPEED, y: body.pos.y -= SPEED)       
        body.x -= SPEED
        body.y -= SPEED        
      end                    
    end        
    
    def move_down_right   
      if can_i_move_there?(x: body.pos.x += SPEED, y: body.pos.y += SPEED)       
        body.y += SPEED
        body.x += SPEED
      end      
    end           
    
    def move_down_left    
      if can_i_move_there?(x: body.pos.x -= SPEED, y: body.pos.y += SPEED)       
        body.x -= SPEED
        body.y += SPEED        
      end                        
    end    
  end
end