module Pugnacious
  class Player
    attr_accessor :pointer, :army, :speed, :control_keys, :color
    SPEED = 4

    def initialize(options = {})                               
      @color = options[:color] || Ray::Color.blue

      position = options[:position] || [200, 200]  

      @control_keys = options[:control_keys]      
      @control_keys ||= [:up, :right, :down, :left]

      @pointer = Ray::Polygon.circle(position, 10, @color , 3, @color)
      @pointer.filled = false
    end                                          

    def move(direction)
      case direction  
      when control_keys_up
        pointer.y += -SPEED          
      when control_keys_right
        pointer.x += SPEED
      when control_keys_down
        pointer.y += SPEED          
      when control_keys_left                   
        pointer.x += -SPEED
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
