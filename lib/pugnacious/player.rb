module Pugnacious
  class Player
    attr_accessor :pointer, :army, :speed, :control_keys

    def initialize(options = {})                               
      color = options[:color]
      color ||= Ray::Color.blue

      position = options[:position] 
      position ||= [200, 200] 

      @control_keys = options[:control_keys]      
      @control_keys ||= [:up, :right, :down, :left]

      @pointer = Ray::Polygon.circle(position, 10, color , 3, color)
      @pointer.filled   = false   

      @speed = 4                       
    end                                          

    def move(direction)
      case direction  
      when control_keys_up
        pointer.y += -speed          
      when control_keys_right
        pointer.x += speed
      when control_keys_down
        pointer.y += speed          
      when control_keys_left                   
        pointer.x += -speed
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
