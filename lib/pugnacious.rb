require_relative 'pugnacious/version' 

module Pugnacious
  class Player
    attr_accessor :pointer, :army, :speed, :control_keys
    
    def initialize(position = [], control_keys = [], color = Ray::Color.blue )
      position |= [200, 200]
      @pointer = Ray::Polygon.circle(position, 10, color, 3, color)
      @pointer.filled   = false   
      
      @speed = 4                  
      
      @control_keys = control_keys | [:up, :right, :down, :left]
    end                                          
    
    def move(direction)
      case direction  
        when control_keys_up
          pos = pointer.pos          
          pointer.pos = [pos.x, (pos.y - speed)]
          
          #pointer.pos.y += -speed          
        when control_keys_right
          pos = pointer.pos
          pointer.pos = [(pos.x + speed), pos.y]
         
          #pointer.pos.x += speed
        when control_keys_down
          pos = pointer.pos
          pointer.pos = [pos.x, (pos.y + speed)]
          
          #pointer.pos.y = pointer.pos.y += speed          
        when control_keys_left                   
          pos = pointer.pos
          pointer.pos = [(pos.x - speed ), pos.y]
          
          #pointer.pos.x += -speed
      end       
    end      
    
    ########################
    # Control keys aliases
    #######################
    
    def control_keys_up
      control_keys[0]
    end             
    
    def control_keys_right
      control_keys[1]
    end         
    
    def control_keys_down
      control_keys[2]
    end       
    
    def control_keys_left
      control_keys[3]
    end
    
  end  
end       